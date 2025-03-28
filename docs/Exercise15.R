#Sarah Culhane, 3/25/2025, daily assighnment 15

# Load the tidymodels package and the penguins dataset
library(tidymodels)
library(palmerpenguins)
library(ranger)
library(workflowsets)

# Set a seed (set.seed())
penguins <- na.omit(palmerpenguins::penguins)
set.seed(123)

# Load the penguins dataset
data("penguins")

# Split the data into training/testing sets with a proportion of 70%/30% split
penguin_split <- initial_split(penguins, prop = 0.7, strata = species)

# Extract the training and test tibbles into unique objects
train_data <- training(penguin_split)
test_data <- testing(penguin_split)

# Create a 10 fold cross validation dataset based on the training data
penguins_folds <- vfold_cv(train_data, v = 10, strata = species)

#part 2: model fitting and workflow

#define a logistic regression model and a rand_forest model
multinom_model <-
  multinom_reg() %>%
  set_engine("nnet") %>%
  set_mode("classification")

#define random forest model
rand_forest_model <-
  rand_forest() %>%
  set_engine("ranger") %>%
  set_mode("classification")

#make workflow_set
penguins_wf_set <-
  workflow_set(
    preproc = list(species ~ .),
    models = list(multinom =
                    multinom_model, rf = 
                    rand_forest_model)
  )

#fit both models with 10-fold cross-validation
penguins_res <- penguins_wf_set %>%
  workflow_map("fit_resamples",
               resamples = penguins_folds, control =
                 control_resamples(save_pred = TRUE))

#generated metrics
penguins_res_metrics <-
collect_metrics(penguins_res) 

#filtered the penguins_res_metrics data set to just the appropriate columns
Penguins_res_metrics_acc <- penguins_res_metrics %>%
  select(.metric, wflow_id, .estimator, mean)

#print results
print(Penguins_res_metrics_acc)



