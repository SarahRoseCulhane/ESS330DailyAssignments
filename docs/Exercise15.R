#Sarah Culhane, 3/25/2025, daily assighnment 15

# Load the tidymodels package and the penguins dataset
library(tidymodels)
library(palmerpenguins)

# Set a seed (set.seed())
set.seed(123)

# Load the penguins dataset
data("penguins")

# Split the data into training/testing sets with a proportion of 70%/30% split
penguin_split <- initial_split(penguins, prop = 0.7)

# Extract the training and test tibbles into unique objects
train_data <- training(penguin_split)
test_data <- testing(penguin_split)

# Create a 10 fold cross validation dataset based on the training data
cv_splits <- vfold_cv(train_data, v = 10)



