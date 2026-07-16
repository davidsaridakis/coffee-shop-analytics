# ☕ Coffee Shop Sales Analytics

An end-to-end data analytics project demonstrating data engineering, SQL development, Python data processing, and business intelligence reporting using a real-world transactional coffee shop dataset.

> **Status:** Dashboard section currently being completed in Power BI. Screenshots will be added once the reporting layer is finalized.

---

# Project Overview

This project explores coffee shop transactional sales data to identify customer purchasing behaviour, operational trends, and business opportunities.

The project was designed to demonstrate a complete analytics workflow, including:

- Data cleaning and preprocessing
- Data validation
- Feature engineering
- Relational database design
- SQL data transformation
- Business-focused SQL analysis
- Power BI dashboard development

Rather than only answering business questions, the project also showcases practical data engineering techniques and analytical best practices.

---

# Business Objectives

The analysis focuses on answering questions such as:

- When are the busiest trading hours?
- How does customer demand differ between weekdays and weekends?
- Which product categories generate the highest revenue?
- Which hours require additional staffing?
- How should bakery production be scheduled?
- Where are opportunities for time-based promotions?

---

# Tech Stack

| Tool | Purpose |
|-------|----------|
| Python | Data preprocessing & validation |
| Pandas | Data cleaning and feature engineering |
| PostgreSQL | Data warehouse & SQL analytics |
| SQL | ETL, views and business analysis |
| Power BI | Dashboarding & visualisation |
| Jupyter Notebook | Exploratory Data Analysis |
| Git / GitHub | Version control |

---

# Dataset

**Coffee Shop Sales Dataset**

Source:
https://www.kaggle.com/datasets

The dataset contains transactional coffee shop sales including:

- Products
- Categories
- Transaction dates
- Transaction times
- Quantities
- Unit prices
- Store locations

---

# Project Structure

```text
coffee-shop-analytics/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── notebooks/
│   └── exploratory_analysis.ipynb
│
├── python/
│   ├── excel_to_csv.py
│   ├── preprocessing.py
│   └── data_validation.py
│
├── sql/
│   ├── 01_init_db.sql
│   ├── 02_create_tables.sql
│   ├── 03_load_and_transform.sql
│   ├── 04_validation.sql
│   ├── 05_views.sql
│   └── 06_business_analysis.sql
│
├── powerbi/
│   └── Coffee Shop Analytics.pbix
│
└── README.md
```

---

# Project Workflow

```text
Raw Excel Dataset
        │
        ▼
Python Cleaning & Validation
        │
        ▼
Feature Engineering
        │
        ▼
Processed Dataset
        │
        ▼
PostgreSQL Database
        │
        ▼
Star Schema + Views
        │
        ▼
Business SQL Queries
        │
        ▼
Power BI Dashboard
```

---

# Python Data Preparation

Python was used to prepare the dataset before loading into PostgreSQL.

Tasks included:

- Converting Excel to CSV
- Data validation
- Duplicate checking
- Data type verification
- Feature engineering
- Revenue calculation
- Weekend flag creation
- Transaction hour extraction

---

# SQL Development

The SQL component includes:

- Database creation
- Table creation
- Data loading
- Validation queries
- Reusable reporting views
- Business analysis queries

The reporting layer is designed around reusable SQL views that can be connected directly to Power BI.

---

# Exploratory Data Analysis

Exploratory analysis was completed in Jupyter Notebook to understand:

- Sales distributions
- Product performance
- Peak trading periods
- Customer purchasing patterns
- Category trends

---

# Power BI Dashboard

**Dashboard screenshots will be added once complete.**

Planned dashboard pages include:

- Executive Sales Overview
- Revenue by Product Category
- Hourly Sales Trends
- Weekday vs Weekend Analysis
- Product Performance
- Operational Insights

### Dashboard Preview

*(Insert screenshots here)*

---

# Key Insights

The analysis identified several operational trends including:

- Morning hours generate the highest customer demand.
- Coffee and bakery products dominate breakfast sales.
- Average hourly demand provides more meaningful staffing insights than total transaction counts.
- Weekday and weekend purchasing patterns differ significantly.
- Demand is concentrated within a relatively small number of trading hours.

---

# Business Recommendations

Based on the analysis:

- Increase staffing during morning peak periods.
- Schedule bakery preparation before breakfast demand.
- Focus promotions around breakfast and coffee bundles.
- Use average hourly demand for workforce planning instead of daily totals.

---

# Skills Demonstrated

- Data Cleaning
- Feature Engineering
- Data Validation
- ETL Development
- PostgreSQL
- SQL Analytics
- Star Schema Design
- Data Modelling
- Business Intelligence
- Power BI
- Python (Pandas)
- Exploratory Data Analysis
- Git Version Control

---

# Future Improvements

- Complete interactive Power BI dashboard
- Add DAX measures
- Implement Power Query transformations
- Publish dashboard to Power BI Service
- Add incremental refresh
- Introduce forecasting models

---

# Author

**Your Name**

Aspiring Data Analyst | SQL | Python | Power BI | PostgreSQL

LinkedIn: *(Add your profile)*

GitHub: *(Add your profile)*