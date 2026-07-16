# ☕ Operational Analytics for Small Hospitality Businesses

## Can transaction data improve operational decisions traditionally driven by intuition?

### Project Overview

Hospitality has always been an industry built on experience. Managers learn when to schedule staff, what products to prepare, and how to organise the day largely through observation and intuition. Having worked in hospitality myself—and having grown up around my mother's café—I wanted to explore a simple question:

> **Can transaction data validate, challenge, or improve those instinctive decisions?**

This project uses a public Kaggle coffee shop dataset as a stand-in for a small independent café. Rather than treating it as a typical sales analysis exercise, I approached it as an operational business case.

The objective was not simply to identify what sold the most, but to investigate whether historical transaction data could support better day-to-day operational decisions around product focus, staffing, and the daily rhythm of the business.

---

## The Business Question

The project was built around one central question:

**Can data analysis provide better operational guidance than intuition alone?**

To answer this, the analysis focused on three areas that directly influence the running of a hospitality business.

### Product Strategy

Which products genuinely drive revenue?

Can transaction data help identify products that deserve greater operational focus, promotion, or menu simplification?

### Staffing & Capacity Planning

How does customer demand change throughout the trading day?

Are staffing decisions supported by demand patterns, or are they based on assumptions?

### Daily Operational Rhythm

Does the business follow predictable trading patterns?

Can transaction data help inform preparation schedules, operational timing, and daily workflow?

Rather than beginning with the data, the project began with these business questions. The analysis was then designed to answer them.

---

## Why This Project Was Built

This project intentionally demonstrates the same analytical workflow across multiple technologies.

The business problem remains constant, while the implementation changes.

* **Python** was used to validate, clean, and engineer analytical features.
* **PostgreSQL** was used to model the data, create reusable reporting views, and answer business questions using SQL.
* **Power BI** recreates the reporting layer to demonstrate dashboard development and Power Query transformations.

Rebuilding the workflow in each environment was a deliberate learning exercise to demonstrate different analytical approaches rather than replicate a production pipeline.

---

## Technical Workflow

```
Business Questions
        ↓
Data Validation
        ↓
Feature Engineering
        ↓
Database Modelling
        ↓
Business Analysis
        ↓
Interactive Reporting
```

Every transformation, SQL query, and dashboard visual was created to support a business question rather than simply explore the dataset.

---

## About the Dataset

This project uses the publicly available **Coffee Shop Sales** dataset from Kaggle.

Although the dataset is not taken from a real business that I have worked with, the analytical questions, feature engineering decisions, and business interpretation were informed by my experience in hospitality and my understanding of how small cafés operate.

The emphasis of the project is therefore not on handling messy real-world data, but on demonstrating how analytical techniques can be applied to operational decision-making.

---

## Current Status

* ✅ Python preprocessing and validation
* ✅ PostgreSQL database design
* ✅ SQL business analysis
* ✅ Exploratory analysis
* 🚧 Power BI dashboard (currently being finalised)

Dashboard screenshots and reporting examples will be added once the Power BI section is complete.

---

## What I Learned

One of the biggest lessons from this project is that analytics and experience are not competing approaches.

Good operational intuition often comes from years of observing customers and understanding how a business functions.

Data analysis provides a way to test those assumptions, uncover patterns that may otherwise be missed, and support decisions with evidence.

For me, that is where analytics creates the most value—not by replacing experience, but by strengthening it.
