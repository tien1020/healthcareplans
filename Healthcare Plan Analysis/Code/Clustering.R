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


#Total.Charges ~ Extended.Stay
#+ APR.Severity.of.Illness.Code
#+ APR.MDC.Code
#+ APR.DRG.Code
#+ CCS.Procedure.Code
#+ CCS.Diagnosis.Code
#+ Length.of.Stay
#+ Operating.Certificate.Number

# inspect types
str(data)

# extended stay should be converted to factor
data$Extended.Stay <- as.factor(data$Extended.Stay)
train$Extended.Stay <- as.factor(train$Extended.Stay)
test$Extended.Stay <- as.factor(test$Extended.Stay)

# need to use mixed categorical and numerical clustering
#install.packages("clustMixType")
library(clustMixType)

df <- data[c("Extended.Stay","APR.Severity.of.Illness.Code","APR.MDC.Code", "CCS.Procedure.Code", "CCS.Diagnosis.Code", "Length.of.Stay", "Operating.Certificate.Number")]

elbowplot <- c()
for (i in 2:14)
{
  clustermodel <- kproto(x=df, k=i)
  elbowplot <- c(elbowplot, clustermodel$tot.withinss)
}
# plot elbowplot
plot(elbowplot)
# save elbow plot
elbowdf <- data.frame(elbowplot)
row.names(elbowdf) <- c(2:14)
elbowdf
write.csv(elbowdf, file ="Data/Clustering-WSS1214.csv", row.names=TRUE)


# save clustered dataframe
#data$cluster <- clustermodel$cluster
#arrow::write_feather(data, "Data/hospital-factorized-clustered.feather")


# summarize data
#grouped <- data %>% 
#  group_by(cluster) %>%
#  summarise_at(vars(Total.Charges, Total.Costs), list(med=median,
#                                                      iqr=IQR)) 
#counts <- data %>% 
#  group_by(cluster) %>%
#  summarise(count=n())
#grouped$counts = counts$count#

#grouped

