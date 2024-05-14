# code to test out the effect of specific variables with importance, i.e. source of payment, using a simple linear regression.
library(dplyr)

data <- read.csv("Desktop/project_data.csv")

# Drop Provider License Number factors since too many levels to interpret
data <- data %>%
  select(
    -Attending.Provider.License.Number,
    -Operating.Provider.License.Number,
    -Other.Provider.License.Number
  )
head(data)
# Get only working adults
data <- data %>%
  filter(Age.Group != "0 to 17") %>%
  filter(Age.Group != "70 or Older")

data$Cost.Shared <- (data$Total.Charges - data$Total.Costs) / data$Total.Charges
colnames(data)

# Train/Test split
data <- na.omit(data)
set.seed(1)
data_split <- sample(c(TRUE, FALSE), nrow(data), replace=TRUE, prob=c(0.7,0.3))
train <- data[data_split, ]
test <- data[!data_split, ]


model <- lm(train$Cost.Shared  ~ train$Source.of.Payment.1, data = train)


summary(model)


write.csv(results, "Data/simple-log-linear.csv", row.names=TRUE)
