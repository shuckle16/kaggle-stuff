library(strapgod)
library(xgboost)

# prelims ----
xgb_params <- list("objective"   = "multi:softprob",
                   "eval_metric" = "mlogloss",
                   "num_class"   = 4)

# model helpers ----
build_tree <- function(df)
{
  rpart(factor(Target) ~ ., data = df)
}

build_multi <- function(df)
{
 multinom(factor(Target) ~ ., data = df)
}

build_rf <- function(df)
{
  randomForest(factor(Target) ~ ., data = df, ntree = 15)
}

build_xgb <- function(df)
{
  X <- df %>% dplyr::select(-Target) %>% as.matrix()
  Y <- df %>% pull(Target) - 1
  
  xgboost(
    xgb.DMatrix(
      data = X,
      label = Y
    ), 
    nrounds = 20, 
    params = xgb_params)
}

# prediction helpers ----
predict_tree <- function(mod, newdat) 
{
  predict(mod, newdata = newdat, type = "class") %>% 
    as.character() %>% 
    as.numeric()
}

predict_multi <- function(mod, newdat) 
{
  predict(mod, newdata = newdat) %>%
    as.character() %>% 
    as.numeric()
}

predict_rf <- function(mod, newdat) 
{
  predict(mod, newdata = newdat) %>% 
    as.character() %>% 
    as.numeric()
}

predict_xgb <- function(mod, newdat) 
{
  newx <- newdat %>% dplyr::select(-Target) %>% as.matrix()
  
  predict(mod, xgb.DMatrix(newx)) %>% 
    matrix(., ncol = 4, byrow = T) %>% 
    max.col() - 1
}

# use bootstrapify to bootstrap the data 30 times ----
# then split into train / test and make use of 
# nested dataframes. keep track of the appropriate
# true values the whole time
cv_df <- 
  train %>% 
  strapgod::bootstrapify(30) %>% 
  collect() %>% 
  group_by(.bootstrap) %>% 
  mutate(
    .train = sample(x = c("test", "train"), size = n(), prob = c(.2, .8), replace = T)
    ) %>% 
  group_by(.bootstrap, .train) %>% 
  nest() %>% 
  spread(key = .train, value = data) %>% 
  mutate(
    treemod    = purrr::map(train, build_tree),
    multinomod = purrr::map(train, build_multi),
    rfmod      = purrr::map(train, build_rf),
    xgbmod     = purrr::map(train, build_xgb)
    ) %>% 
  mutate(
    treepreds     = purrr::map2(treemod, test, predict_tree),
    multinompreds = purrr::map2(multinomod, test, predict_multi),
    rfpreds       = purrr::map2(rfmod, test, predict_rf),
    xgbpreds      = purrr::map2(xgbmod, test, predict_xgb)
    ) %>% 
  mutate(
    actual = purrr::map(test,~.x %>% pull(Target)))

# evaluate ----
votes_df <- 
  cv_df %>% 
  unnest(treepreds, multinompreds, rfpreds, xgbpreds, actual)

# auc plot
auc_plot <- 
  votes_df %>% 
  gather(key = model, value = pred, -.bootstrap,-actual) %>% 
    group_by(.bootstrap, model) %>% 
    summarize(
      auc = pROC::multiclass.roc(pred, actual)$auc
      ) %>%
    mutate(
      model = str_replace(string = model, pattern = "preds", replacement = "")
      ) %>% 
    ggplot(aes(x = reorder(model,auc), y = auc)) + 
      geom_boxplot(fill = "navy", alpha = .4) + 
      xlab("model") +
      ggtitle("Cross Validated Performance of 4 Different Models",
              subtitle = "Complexities in the data call for complicated models") +
      theme(title = element_text(size = 20))

ggsave("pics/cv-aucs.png", plot = auc_plot)
