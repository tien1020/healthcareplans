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


model <- lm(train$Cost.Shared  ~ train$CCS.Procedure.Description, data = train)


summary(model)

model_summary <- capture.output(summary(model))
write.csv(model_summary, "Desktop/simple-log-linear_procedure_description.csv", row.names=TRUE)
