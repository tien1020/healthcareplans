# step regression on Total Charges
formula_all <- paste(x_cols, collapse="+")
formula_all <- formula(paste("Total.Charges ~", formula_all))

model_a0 <- lm(Total.Charges ~ 1, data=train_sel)
model_step <- step(model_a0, formula_all, direction="both")
save(model_step, file="Data/step-total-charges.RData")

# model using features selected from step regression on test set
model_charges <- lm(formula(model_step), data=test)
save(model_charges, file="Data/step-total-charges-model.RData")

# step regression on Cost Shared
formula_all <- paste(x_cols, collapse="+")
formula_all <- formula(paste("Cost.Shared ~", formula_all))

model_a0 <- lm(Cost.Shared ~ 1, data=train_sel)
model_step <- step(model_a0, formula_all, direction="both")
save(model_step, file="Data/step-cost-shared.RData")

# model using features selected from step regression on test set
model_shared <- lm(formula(model_step), data=test)
save(model_shared, file="Data/step-cost-shared-model.RData")
