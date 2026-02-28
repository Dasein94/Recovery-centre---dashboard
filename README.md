# (Re)Creating a Dashboard for a Substance Misuse Recovery Centre 

## Overview

While working at a drug & alcohol recovery centre, I developed an automated Excel dashboard using VBA macros to streamline reporting and improve data visibility. The dashboard integrated multiple datasets, reduced time spent generating reports, and highlighted patterns in client engagement and service use.
This project recreates that dashboard using synthetic data. It focuses on first assessment attendance (Completed, Did Not Attend, Rearranged), referral source, and assigned keyworker.

## Objectives

- Reproduce the original service dashboard using synthetic data.
- Conduct descriptive analysis of assessment outcomes.
- Examine whether clients referred through the criminal justice system (police, probation, prison leavers) were less likely to complete their first assessment compared to non-criminal referrals (self, hospital, GP).
- Strengthen and demonstrate applied skills in Excel (PivotTables, slicers, VBA) and statistical analysis in R (logistic regression).

## Structure

```
Recovery-centre---dashboard/
    ├── README.md
    ├── DB_Organization.xlsm
    ├── VBA/
    │   ├── Module1.bas
    │   ├── Sheet1.cls
    │   ├── Sheet2.cls
    └── R/
        ├── synthetic_data.R
        └── data_analysis.R
```

### File Descriptions

- **DB_Organization.xlsm** – Excel dashboard with pivot tables 
- **VBA/** – Contains macro code for dashboard automation.
- **R/synthetic_data.R** – Generates client-level and assessment-level synthetic datasets.
- **R/data_analysis.R** – Performs χ² test and logistic regression analysis.

***Requirements. Excel with macros enabled. Optional – R. Packages: charlatan, dplyr, tidyr, lubridate.***

## Process

### 1. Synthetic Data Generation
Recreated the core variables from the original dashboard using synthetically generated data in R.
### 2. Dynamic Pivot Tables & VBA Automation
Built PivotTables summarizing assessment attendance, substance group, and referral source. The tables were linked to the main dataset, ensuring automatic updates with VBA macros when new records are added. 
VBA macros was also implemented to identify clients whose assessments were rearranged multiple times. Additionally, the table also displays a chronologically ordered list of all assessments when the macro button is clicked.
### 3. Interactive Dashboard
Designed a dashboard using dynamic charts and slicers, allowing real-time filtering by keyworker and time period.
### 4. Statistical Analysis in R
- Conducted a contingency table analysis and χ² test to examine the association between referral source and assessment completion.
- Fitted a logistic regression model to estimate the odds of completing an assessment based on referral source.

## Key Findings

### Brief Data description
- There were 764 assessments, half of them completed.
- 263 assessments were referred by the criminal justice system. 
- Assessments took place between October 2024 and November 2026. 
- 320 unique clients (33% did not attend).
- Majority of assessments were booked to get support for alcohol (51%), and opiates (20%).
- Referrals to the service increase with time. Month comparison of assessments vs referrals shows assessments are largely covered. There are also more referrals than assessments.

### Data Analysis
**Assessment Completion by Referral Source**:
Analysis of assessment outcomes revealed a clear difference between referral groups. Individuals referred by non-criminal sources (self, hospital, GP) were nearly three times more likely to complete the assessment compared with those referred by criminal justice services (OR = 2.94, 95% CI [2.16, 4.02], p < 0.001).

**Criminal Justice Referrals Breakdown**:
Within the criminal justice referrals, prison leavers were less likely to attend their first assessment compared with individuals referred by the police or probation services. The highest completion rates were observed among probation referrals, likely reflecting the influence of mandatory treatment requirements.

*Summary Table – Odds Ratios for Completion*
|     Predictor   |    OR    |   95% CI   |  *p-value* |
|-----------------|----------|------------|------------|
|     Intercept   |   0,57   | 0,44-0,73  | 8.95e-06   |
|    Non-criminal |   2,94   | 2.16-4.02  | 8.46e-12   |





