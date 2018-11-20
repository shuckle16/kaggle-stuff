library(tidyverse)
library(randomForest)
library(pROC)

train <- read_csv("train.csv")
test  <- read_csv("test.csv")

train %>% count(Id)
train %>% count(Target) %>% ggplot(aes(x = Target, y = n)) + geom_col()
train %>% count(idhogar) %>% count(n) %>% ggplot(aes(x = n, y = nn)) + geom_col()

train %>% count(idhogar, Target) %>% count(idhogar)

no_nas <- function(x) {
  !any(is.na(x))
}

simple_basetable <-
  train %>% 
  dplyr::select(-Id, -idhogar) %>%
  dplyr::select_if(is.numeric) %>%  
  dplyr::select_if(no_nas) %>% 
  dplyr::select_if(.predicate = funs(sd(.) > 0))

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

# random forest
rfmod <- randomForest(factor(Target) ~ ., 
             data = simple_train, 
             ntree = 15)

table(pred = predict(rfmod, newdata = simple_test) %>% as.character() %>% as.numeric(), actual = simple_test$Target)
pROC::multiclass.roc(predict(rfmod, newdata = simple_test) %>% as.character() %>% as.numeric(), simple_test$Target)

# one tree
treemod <- rpart(factor(Target) ~ ., data = simple_train)

table(pred = predict(treemod, newdata = simple_test, type = "class") %>% as.character() %>% as.numeric(), actual = simple_test$Target)
pROC::multiclass.roc(predict(treemod, newdata = simple_test, type = "class") %>% as.character() %>% as.numeric(), simple_test$Target)

