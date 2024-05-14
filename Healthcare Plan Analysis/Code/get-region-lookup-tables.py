'''Create CSV lookup tables for Facilitys to Operating Certificate Number and
   County to Health Service Area'''

from pathlib import Path
import pandas as pd

columns_to_read = ['Health.Service.Area',
                   'Hospital.County',
                   'Operating.Certificate.Number',
                   'Facility.ID',
                   'Facility.Name'
]

# Need to convert raw dataset to feather with R script before running
data_path = Path("Data/hospital.feather")
if data_path.is_file():
    df = pd.read_feather(data_path)
else:
    raise OSError("Data file does not exist")

# Need to have Facility_ID.csv lookup dict
dict_path = Path("Data/Facility_ID.csv")
if dict_path.is_file():
    facility_dict = (
            pd.read_csv(dict_path).set_index('Facility.ID')['Facility.Name']
            .to_dict()
    )
else:
    raise OSError("Data file does not exist")

# Drop redacted abortion facilities and duplicates
df = df.dropna().drop_duplicates()

# Convert IDs from float to int
for j in ['Operating.Certificate.Number', 'Facility.ID']:
    df[j] = df[j].astype(int)

# Get lookup of OCN with respective facility or facilities
ocn_vs_facility = (df[['Operating.Certificate.Number', 'Facility.ID']]
                   .drop_duplicates())
grouper = ocn_vs_facility.groupby('Operating.Certificate.Number',
                                  as_index=False)
ocn_vs_facility = grouper['Facility.ID'].apply(list)
ocn_vs_facility['Facility.Name'] = (
        ocn_vs_facility['Facility.ID']
        .apply(lambda x: [facility_dict[v] for v in x])
)
ocn_vs_facility.to_csv("Data/ocn-vs-facility.csv", index=False)

# Get lookup of HSA with respective county or counties
hsa_vs_county = (df[['Health.Service.Area', 'Hospital.County']]
                 .drop_duplicates())
grouper = hsa_vs_county.groupby('Health.Service.Area', as_index=False)
hsa_vs_county = grouper['Hospital.County'].apply(list)
hsa_vs_county.to_csv("Data/hsa-vs-county.csv", index=False)