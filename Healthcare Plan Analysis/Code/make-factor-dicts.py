'''Creates CSV lookup dictionaries for already existing dummy variables in
   hospital dataset'''

from pathlib import Path
import pandas as pd

# Need to convert raw dataset to feather with R script before running
data_path = Path("Data/hospital.feather")
if data_path.is_file():
    df = pd.read_feather(data_path)
else:
    raise OSError("Data file does not exist")

factor_pairs = [
        ('Facility.ID', 'Facility.Name'),
        ('CCS.Diagnosis.Code', 'CCS.Diagnosis.Description'),
        ('CCS.Procedure.Code', 'CCS.Procedure.Description'),
        ('APR.DRG.Code', 'APR.DRG.Description'),
        ('APR.MDC.Code', 'APR.MDC.Description'),
        ('APR.Severity.of.Illness.Code', 'APR.Severity.of.Illness.Description')
]

# Handles redacted abortion facilities having missing Facility IDs
df['Facility.ID'].fillna(0, inplace=True)

for k,v in factor_pairs:
    unique_pairs = df[[k,v]]
    unique_pairs = unique_pairs[unique_pairs[k].notna()]
    unique_pairs.drop_duplicates(inplace=True)
    unique_pairs.sort_values(by=k, inplace=True)
    unique_pairs[k] = unique_pairs[k].astype(int, copy=False)
    if (len(unique_pairs) != len(unique_pairs[k].drop_duplicates())):
        print("Warning: Indicator variable may have more than one categorical"
              "value")
    
    unique_pairs.to_csv("Data/%s.csv" % k.replace('.', '_'), index=False)
    
