# Team-72
 Team 72's group project GitHub repository for MGT 6203 (Canvas) Fall of 2023 semester.

## Project Summary

## Getting Started

### Prerequisites

* Raw dataset CSV file placed in the 'Data' directory, which can be downloaded from the following link:
https://www.kaggle.com/datasets/thedevastator/2010-new-york-state-hospital-inpatient-discharge

* R Version 4.3 with the following packages:
    - dplyr
    - arrow
    - glmnet

* RStudio 2023:
    - Installer and instructions can be found in the following link: https://posit.co/download/rstudio-desktop/
    - R packages can be installed in RStudio by searching under the Tools > Install Packages menu

* Miniconda3 with Python 3.x:
    - Installer and instructions can be found in the following link: https://docs.conda.io/projects/miniconda/en/latest/
    - Python packages can be installed from an Anaconda shell. The pandas and pyarrow packages are required:
  
    ```sh
        conda config --add channels conda-forge
        conda install -c conda-forge pandas
        conda install -c conda-forge pyarrow
    ```

### Usage

The project's parent directory should be set to the working directory in RStudio prior to running any R scripts.

The 'Code/factorize.R' script should be run at least once to perform preliminary data cleaning and factorization.
The output will be a reduced size .feather file that can be used for later processing and modeling.

The 'Code/preprocessing.R' script is used to preprocess and split data into training and test sets.
This must be run prior to running any of the regression scripts (e.g. 'Code/step-regression.R').

The python scripts can be run from an Anaconda shell by navigating to the project's parent directory then running a command like the following:
```sh
    python Code\get-important-features.py
```

CSV files summarizing the outputs and results of the scripts and models can be found in the Data directory for viewing.

## Project Description

### Abstract

This paper presents a data-driven approach to analyze health insurance plans for our New York-based company. Our goal is to identify and evaluate insurance plans that reduce costs for employees while matching their risk levels. By using a detailed dataset that includes charges and medical service information from different New York hospitals and medical centers, we examine the factors contributing to healthcare costs and charges, focusing on the most important coverages to include in our company's health insurance plan. The analysis utilizes linear regression models with feature selection from step regression and LASSO regression. Our analysis will provide insights to find insurance options that optimize coverage and minimize financial burdens for our valued employees.

### Introduction

Our New York-based company is looking for the best insurance plans for our employees. To achieve this, we are starting on a data-driven approach to analyze insurance plans. We were provided a dataset with information about the charges and medical services from different hospitals and medical centers around New York. By leveraging our database's wealth of information, we aim to find insurance options that optimize coverage and minimize financial burdens for our valued employees.

### Methodology

The two fields corresponding with financial figures are Total Charges and Total Costs. Total charges represent the amount the facility charged for services, while total costs is the amount billed to patients after insurance and other coverage deductions. 
The average length of stay is 5.5 days and stays between 1 to 5 days make up 39.6% of total costs. A key feature in this field is, as previously stated,that any stay of 120 days and above was represented by “120+”, causing a large segment group being made for those data points. The use of our indicator variable Extended Stay would address this grouping. Additionally, costs shared amount (Total Charges – Total Costs) was a calculated field used to evaluate the amount of
APR Risk of Mortality. This field measured the risk level of a patient’s need of care and included nulls representing observations redacted due to being pregnancy/childbirth related. 

### Analytical Methods

* Linear Regression
* Bi-directional step regression
* LASSO models
* kprototype clustering
* Holt-Winters forecasting


### Recommendations

* Choosing significantly decreased in Cost Shares.
* Regional Health Plans
* Source of payment: CHAMPUS
* Critical Illness Insurance


