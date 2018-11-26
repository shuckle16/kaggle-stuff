library(tidyverse)
library(rpart)
library(pROC)
library(randomForest)

train <- read_csv("train.csv")
test  <- read_csv("test.csv")

# re-assign Targets to appropriate head of household Targets ----
get_parent_targets <- function(df) {
  df %>% 
    filter(parentesco1 == 1) %>%
    dplyr::select(idhogar, hh_Target = Target)
}

train_parent_targets <- get_parent_targets(train)

train <- 
  train %>% 
  left_join(train_parent_targets) %>% 
  mutate(
    Target = if_else(is.na(hh_Target), Target, hh_Target)
  )

# remove the annoying variables for now ----
simple_basetable <-
  train %>% 
  dplyr::select(-Id, -idhogar, -hh_Target) %>%
  dplyr::select_if(is.numeric) %>%  
  dplyr::select_if(no_nas) %>% 
  dplyr::select_if(.predicate = funs(sd(.) > 0))

# split up train and test
train_rows <- sample(x = 1:nrow(simple_basetable), size = 0.8 * nrow(simple_basetable))

simple_train <- 
  simple_basetable %>% 
  filter(
    row_number() %in% train_rows
  )

simple_test <-
  simple_basetable %>% 
  filter(
    !(row_number() %in% train_rows)
  )

# single tree model ----
treemod <- rpart(factor(Target) ~ ., data = simple_train)

table(pred = predict(treemod, newdata = simple_test, type = "class") %>% as.character() %>% as.numeric(), actual = simple_test$Target)
pROC::multiclass.roc(predict(treemod, newdata = simple_test, type = "class") %>% as.character() %>% as.numeric(), simple_test$Target)

# random forest ----
rfmod <- randomForest(factor(Target) ~ ., 
                      data = simple_train, 
                      ntree = 15,
                      importance = T)

table(pred = predict(rfmod, newdata = simple_test) %>% as.character() %>% as.numeric(), actual = simple_test$Target)
pROC::multiclass.roc(predict(rfmod, newdata = simple_test) %>% as.character() %>% as.numeric(), simple_test$Target)

varImpPlot(rfmod)
