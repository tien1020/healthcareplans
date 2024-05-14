# add log transformed x predictors
x_log_cols <- x_cols
for (x in c('Length.of.Stay', 'Birth.Weight')) {
    x_log_cols <- c(x_log_cols, paste("log(", x, "+1)", sep=""))
}

results <- data.frame(matrix(nrow=0, ncol=2))

# get R-Squared of all simple linear models for Total Charges
y_mean <- mean(train$Total.Charges)
SST <- sum((train$Total.Charges - y_mean)^2)
for (x in x_log_cols) {
    formula_x <- paste('Total.Charges ~', x)
    print(formula_x)
    model_x <- lm(formula(formula_x), data=train)
    SSR <- sum((model_x$residuals)^2)
    rsquared <- 1 - (SSR/SST)
    print(rsquared)
    results <- rbind(results, c(formula_x, rsquared))
}

# get R-Squared of all simple linear models for Cost Shared
y_mean <- mean(train$Cost.Shared)
SST <- sum((train$Cost.Shared - y_mean)^2)
for (x in x_log_cols) {
    formula_x <- paste('Cost.Shared ~', x)
    print(formula_x)
    model_x <- lm(formula(formula_x), data=train)
    SSR <- sum((model_x$residuals)^2)
    rsquared <- 1 - (SSR/SST)
    print(rsquared)
    results <- rbind(results, c(formula_x, rsquared))
}

colnames(results) <- c('Formula', 'R.Squared')
write.csv(results, "Data/simple-linear.csv", row.names=TRUE)
