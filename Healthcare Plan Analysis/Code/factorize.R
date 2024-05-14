# Handles data preprocessing needed prior to factorizing and saving hospital
# data as a feather file

library(dplyr)
#library(arrow)


# Declare paths to data files
PATH_RAW <-
    "Data/hospital-inpatient-discharges-sparcs-de-identified-2010-1.csv"
PATH_FEATHER <- "Data/hospital.feather"
PATH_OUT <- "Data/hospital-factorized.feather"


if (file.exists(PATH_FEATHER)) {
    data <- arrow::read_feather(PATH_FEATHER)
} else {
    data <- read.csv(PATH_RAW, header=TRUE)
    # Uncomment out if want to immediately store raw data as feather
    # write_feather(data, "Data/hospital.feather")
}


# Drop name/description variables since they have already been dummified
# Discharge Year is also dropped since only 2010 data is part of the dataset
data <- data %>%
    select(-index,
           -Facility.Name,
           -Discharge.Year,
           -CCS.Diagnosis.Description,
           -CCS.Procedure.Description,
           -APR.DRG.Description,
           -APR.MDC.Description,
           -APR.Severity.of.Illness.Description
    )


# Handle following variables which are redacted or NA for abortion facilities
data <- data %>%
    mutate(Facility.ID = replace(Facility.ID, is.na(Facility.ID), 0)) %>%
    mutate(Health.Service.Area =
           replace(Health.Service.Area, Health.Service.Area == "", "Redacted")
    ) %>%
    mutate(Hospital.County =
           replace(Hospital.County, Hospital.County == "", "Redacted")) %>%
    mutate(Operating.Certificate.Number =
           replace(Operating.Certificate.Number,
                   is.na(Operating.Certificate.Number), 0)
    ) %>%
    mutate(Attending.Provider.License.Number =
           replace(Attending.Provider.License.Number,
                   is.na(Attending.Provider.License.Number), 0)
    )


# Convert integer variables that should be considered categorical into factors
indicators <- c('Operating.Certificate.Number',
                'Facility.ID',
                'CCS.Diagnosis.Code',
                'CCS.Procedure.Code',
                'APR.DRG.Code',
                'APR.MDC.Code',
                'APR.MDC.Description',
                'APR.Severity.of.Illness.Code',
                'Attending.Provider.License.Number',
                'Operating.Provider.License.Number',
                'Other.Provider.License.Number'
)
data <- mutate_if(data, colnames(data) %in% indicators, as.factor)


# Only get first 3 characters of Zip Code string since some values are decimal
# (ex. "102.0" should be same as "102"). "OOS" or Out of State values are not
# affected since it is already only 3 characters.
data$Zip.Code...3.digits <- substr(data$Zip.Code...3.digits, 1, 3) 


# Separate Length of Stay between numerical variable with values <120 days and
# new indicator variable if >120 days
data <- data %>%
    mutate(Extended.Stay =
           as.integer(if_else(Length.of.Stay == "120 +", 1, 0))) %>%
    mutate(Length.of.Stay =
           replace(Length.of.Stay, Length.of.Stay == "120 +",120)) %>%
    mutate(Length.of.Stay = as.integer(Length.of.Stay))
    

# Handles NA case when Severity of Illness is 0 which causes Risk of Mortality
# field to be empty
data <- data %>%
    mutate(APR.Risk.of.Mortality =
           replace(APR.Risk.of.Mortality, APR.Risk.of.Mortality == "",
                   "None")
    )


# Replace empty non-primary source of payments with "None" category
data <- data %>%
    mutate(Source.of.Payment.2 =
           replace(Source.of.Payment.2,
                   Source.of.Payment.2 == "", "None")
    ) %>%
    mutate(Source.of.Payment.3 =
               replace(Source.of.Payment.3,
                       Source.of.Payment.3 == "", "None")
    )


# Fill empty values with NA
data <- mutate_if(data, is.character, ~na_if(., ""))


# Convert all remaining categorical variables to factors to save space
data <- mutate_if(data, is.character, as.factor)


# Write to feather file
arrow::write_feather(data, PATH_OUT)

# Free memory
gc()
#test edit
