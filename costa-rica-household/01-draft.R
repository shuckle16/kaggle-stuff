library(tidyverse)
library(rpart)
library(rpart.plot)
library(nnet)
library(randomForest)
library(pROC)

cost_rica <- read_csv("train.csv")

# re-assign Targets to appropriate head of household Targets ----
parent_targets <- 
  costa_rica %>% 
  filter(parentesco1 == 1) %>%
  dplyr::select(idhogar, hh_Target = Target)

simple_basetable <- 
  costa_rica %>% 
  left_join(parent_targets) %>% 
  mutate(
    Target = if_else(is.na(hh_Target), Target, hh_Target)
  )

# remove the annoying variables for now ----
no_nas <- function(x) {
  !any(is.na(x))
}

simple_basetable <-
  simple_basetable %>% 
  dplyr::select(-Id, -idhogar, -hh_Target) %>%
  dplyr::select_if(is.numeric) %>%  
  dplyr::select_if(no_nas) %>% 
  dplyr::select_if(.predicate = funs(sd(.) > 0))

# split up train and test ----
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

# random forest ----
rfmod <- randomForest(factor(Target) ~ ., 
                      data = simple_train, 
                      ntree = 25,
                      importance = T)

rfpred <- predict(rfmod, newdata = simple_test) %>% as.character() %>% as.numeric()

table(pred = rfpred, actual = simple_test$Target)
pROC::multiclass.roc(rfpred, simple_test$Target)

varImpPlot(rfmod)
