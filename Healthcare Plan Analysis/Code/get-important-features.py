'''Get only simple regression models that were significant from feature
   selection process'''

import pandas as pd

results = pd.read_csv("Data/regression-results.csv")
simple_linear = pd.read_csv("Data/simple-linear.csv")

# important features are superset of all predictors from each method
important_features = dict()
important_features['Total.Charges'] = set()
important_features['Cost.Shared'] = set()

# get predictors by parsing formula
for formula in results['Linear Regression Formula']:
    response, predictors = formula.split(' ~ ')
    predictors = {x.strip() for x in predictors.split(' + ')}
    important_features[response].update(predictors)

r_squared = list()

# filter R-Squared values
for y in important_features:
    for x in important_features[y]:
        formula = "%s ~ %s" % (y, x)
        x_row = simple_linear[simple_linear['Formula'] == formula].iloc[0]
        r_squared.append([y, x, x_row['R.Squared']])
        
    
df  = pd.DataFrame(r_squared, columns=['y', 'x', 'R-Squared'])
df.sort_values(by='R-Squared', ascending=False, ignore_index=True,
               inplace=True)

df.to_csv("Data/simple-linear-important.csv", index=False)