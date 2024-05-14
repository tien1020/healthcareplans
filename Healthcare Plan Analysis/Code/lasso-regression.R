# feature select Total Charges with LASSO
lasso_charges <- glmnet::glmnet(as.matrix(select(train, all_of(x_cols))),
                                as.matrix(select(train, Total.Charges)),
                                family="gaussian", alpha=1, standardize=TRUE) 

num_vars <- c()
for (i in 1:length(lasso_charges$lambda)) {
  # extract coefficients for given values of lambda then sum number of nonzero variables (excluding intercept)
  num_vars <- c(num_vars, sum(coef(lasso_charges, s=lasso_charges$lambda[i]) != 0) - 1)
}

# use plots to pick value for lambda that balances tradeoff between
# number of variables selected and fraction of deviance explained
par(mfrow = c(1, 2))
plot(lasso_charges$lambda, num_vars, xlab="Lambda", ylab="Number of Variables")
plot(lasso_charges$lambda, lasso_charges$dev.ratio, xlab="Lambda", ylab="Dev.Ratio")

# lambda = 83.3 gives 8 variables with Dev.Ratio ~ 0.4824
coef_charges = coef(lasso_charges, 83.3)
# get factors with nonzero coefficients excluding intercept
factors_charges = coef_charges@Dimnames[[1]][coef_charges@i+1][-1]

# feature select Cost Shared with LASSO
lasso_shared <- glmnet::glmnet(as.matrix(select(train, all_of(x_cols))),
                               as.matrix(select(train, Cost.Shared)),
                               family="gaussian", alpha=1, standardize=TRUE) 

num_vars <- c()
for (i in 1:length(lasso_shared$lambda)) {
    # extract coefficients for given values of lambda then sum number of nonzero variables (excluding intercept)
    num_vars <- c(num_vars, sum(coef(lasso_shared, s=lasso_shared$lambda[i]) != 0) - 1)
}

# use plots to pick value for lambda that balances tradeoff between
# number of variables selected and fraction of deviance explained
par(mfrow = c(1, 2))
plot(lasso_shared$lambda, num_vars, xlab="Lambda", ylab="Number of Variables")
plot(lasso_shared$lambda, lasso_shared$dev.ratio, xlab="Lambda", ylab="Dev.Ratio")

# lambda = 1.68e-04 gives 8 variables with Dev.Ratio ~ 0.0306
coef_shared = coef(lasso_shared, 1.68e-4)
# get factors with nonzero coefficients excluding intercept
factors_shared = coef_shared@Dimnames[[1]][coef_shared@i+1][-1]

# linear regression models using selected variables
formula_charges <- paste("Total.Charges ~", paste(factors_charges, collapse=' + '))
formula_charges <- formula(formula_charges)
model_charges <- lm(formula_charges, data=test)

save(model_charges, file="Data/lasso-total-charges-model.RData")

formula_shared <- paste("Cost.Shared ~", paste(factors_shared, collapse=' + '))
formula_shared <- formula(formula_shared)
model_shared <- lm(formula_shared, data=test)

save(model_shared, file="Data/lasso-cost-shared-model.RData")
