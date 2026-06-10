# Healthcare-Patient-Operations-Analytics

## Project Overview

This project analyzes hospital operations, patient demographics, appointment trends, treatment performance, and financial data using **MySQL** and **Microsoft Excel**. The goal is to transform raw healthcare data into meaningful business insights through data cleaning, SQL analysis, and interactive dashboard development.

The project follows a complete data analytics workflow, beginning with raw CSV files and ending with an executive-level dashboard suitable for business decision-making.

---

## Project Objectives

* Import and manage healthcare data in MySQL
* Perform data quality checks and cleaning
* Standardize and validate patient and operational data
* Conduct exploratory and advanced SQL analysis
* Generate business insights using SQL queries
* Build an interactive Excel dashboard for stakeholders

---

## Dataset

**Dataset:** Hospital Management Dataset

**Source:** Kaggle

The dataset consists of five primary tables:

* Patients
* Doctors
* Appointments
* Treatments
* Billing

---

## Tools & Technologies

* MySQL
* Microsoft Excel
* SQL
* Pivot Tables
* Pivot Charts
* Window Functions
* Common Table Expressions (CTEs)
* Data Cleaning
* Business Intelligence

---

## Project Workflow

```text
Kaggle Dataset
       ↓
Import into MySQL
       ↓
Data Quality Checks
       ↓
Data Cleaning & Standardization
       ↓
Exploratory SQL Analysis
       ↓
Advanced SQL Analytics
       ↓
Export Cleaned Data
       ↓
Excel Dashboard Development
```

---

## Data Quality & Cleaning

The following data quality checks and transformations were performed:

* Checked for duplicate patient records
* Identified duplicate email addresses
* Verified missing values
* Standardized gender values
* Validated appointment statuses
* Verified payment information
* Created age and age group categories
* Ensured consistency across related tables

---

## Exploratory SQL Analysis

Key business questions answered include:

* How many patients are in the system?
* What is the patient demographic distribution?
* Which insurance providers are most common?
* What are the busiest appointment periods?
* Which doctors handle the highest appointment volumes?
* Which treatments are performed most frequently?
* What are the highest revenue-generating treatments?
* What are the overall billing trends?

---

## Advanced SQL Analytics

Advanced SQL techniques used in this project include:

* CTEs (Common Table Expressions)
* Window Functions
* RANK() and DENSE_RANK()
* ROW_NUMBER()
* LAG()
* Running Totals
* Rolling Averages
* Revenue Ranking
* Patient Visit Analysis

Business analyses include:

* Doctor revenue ranking
* Monthly revenue growth
* Patient loyalty analysis
* Treatment profitability
* Revenue contribution by payment status
* Appointment trend analysis

---

## Excel Dashboard

An interactive Excel dashboard was created to visualize key hospital performance metrics.

### Dashboard KPIs

* Total Patients
* Total Doctors
* Total Appointments
* Total Revenue
* Average Treatment Cost
* Appointment Completion Rate
* No-Show Rate

### Dashboard Visualizations

* Appointment Status Distribution
* Revenue by Treatment Type
* Top Doctors by Appointment Volume
* Patient Age Distribution
* Revenue by Payment Method
* Monthly Revenue Trend

---

## Key Business Insights

The dashboard enables healthcare administrators to:

* Monitor operational efficiency
* Track appointment outcomes
* Identify high-performing doctors
* Understand patient demographics
* Analyze treatment profitability
* Monitor hospital revenue trends
* Support data-driven decision making

---

## Repository Structure

```
Healthcare-Patient-and-Operations-Analytics/
│
├── README.md
│
├── data/
│   ├── patients.csv
│   ├── doctors.csv
│   ├── appointments.csv
│   ├── treatments.csv
│   └── billing.csv
│
├── sql/
│   ├── data_quality_checks.sql
│   ├── data_cleaning.sql
│   ├── exploratory_analysis.sql
│   └── advanced_analysis.sql
│
├── dashboard/
│   └── Healthcare_Operations_Dashboard.xlsx
│
├── screenshots/
│   ├── dashboard_overview.png
│   ├── patient_insights.png
│   └── financial_analysis.png
│
└── assets/
    └── erd.png
```

---

## Skills Demonstrated

### SQL

* Data Cleaning
* Data Validation
* Joins
* Aggregations
* CTEs
* Window Functions
* Ranking Functions
* Business Query Development

### Excel

* Data Import
* Excel Tables
* Pivot Tables
* Pivot Charts
* KPI Cards
* Interactive Dashboard Design
* Data Visualization

### Business Intelligence

* Operational Analytics
* Financial Analytics
* Patient Analytics
* Healthcare Reporting
* KPI Development
* Executive Dashboarding

---

## Dashboard Preview

*Dashboard screenshots are available in the `/screenshots` folder.*

---

## Portfolio Project Series

This project is part of a larger data analytics portfolio demonstrating proficiency across multiple visualization platforms.

| Project                                   | Tools           |
| ----------------------------------------- | --------------- |
| Retail Sales Analytics                    | MySQL, Tableau  |
| Employee Analytics                        | MySQL, Power BI |
| Healthcare Patient & Operations Analytics | MySQL, Excel    |

---

## Author

**Regina Mayiie Kamara**

Aspiring Data Analyst | Business Intelligence Enthusiast | SQL & Data Visualization Portfolio Projects
