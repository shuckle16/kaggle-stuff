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
  
cv_df <- 
  simple_basetable %>% 
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
cv_df %>% 
  unnest(treepreds, multinompreds, rfpreds, xgbpreds)
