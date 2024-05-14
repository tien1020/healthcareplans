library(dplyr)

data <- arrow::read_feather("Data/hospital-factorized.feather")

# Drop Provider License Number factors since too many levels to interpret
data <- data %>%
    select(
        -Attending.Provider.License.Number,
        -Operating.Provider.License.Number,
        -Other.Provider.License.Number
    )

# Get only working adults
data <- data %>%
    filter(Age.Group != "0 to 17") %>%
    filter(Age.Group != "70 or Older")

# Calculate cost shared as a fraction of total charges
data$Cost.Shared <- (data$Total.Charges - data$Total.Costs) / data$Total.Charges

# Train/Test Split
data <- na.omit(data)
set.seed(1)
data_split <- sample(c(TRUE, FALSE), nrow(data), replace=TRUE, prob=c(0.7,0.3))
train <- data[data_split, ]
test <- data[!data_split, ]

# Split response variables from predictors
data_cols <- colnames(data)
x_cols <- data_cols[!(data_cols %in% c('Total.Charges', 'Total.Costs', 'Cost.Shared'))]

# Sample 5% of train data in if still too much data to use for modeling
set.seed(1)
data_split <- sample(c(TRUE, FALSE), nrow(train), replace=TRUE, prob=c(0.05,0.95))
train_sel <- train[data_split, ]