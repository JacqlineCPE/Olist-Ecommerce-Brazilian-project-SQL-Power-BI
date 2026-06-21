# Olist E-Commerce Performance Analysis

### SQL Server + Power BI | End-to-End Business Intelligence Project

---

## Executive Summary

This project analyzes the Olist Brazilian E-commerce dataset to evaluate business performance across sales, profitability, customer satisfaction, and delivery operations.

Using SQL Server for data preparation and Power BI for visualization, I developed an interactive business intelligence solution that transforms raw transactional data into actionable insights.

The analysis reveals strong revenue growth, identifies the most profitable states and product categories, and uncovers operational challenges within the delivery process that directly impact customer satisfaction.

The final solution consists of two dashboards:

* **Executive Overview Dashboard** — Financial and profitability performance.
* **Customer & Delivery Performance Dashboard** — Customer experience and logistics efficiency.

---

# Business Problem

Olist is a Brazilian e-commerce marketplace connecting small businesses with customers across the country.

As transaction volumes increase, management requires visibility into:

* Revenue performance
* Profitability drivers
* Customer satisfaction
* Delivery efficiency
* Regional performance differences

Without a centralized reporting solution, it becomes difficult to identify opportunities, monitor operational performance, and make data-driven decisions.

This project addresses that challenge by providing an interactive analytics solution that connects financial performance with customer and operational outcomes.

---

# Business Questions

This analysis was designed to answer the following questions:

### Financial Performance

* How much revenue is the business generating?
* Which states contribute the most profit?
* Which product categories drive profitability?
* Is revenue growth translating into stronger margins?

### Customer Experience

* How satisfied are customers with their purchases?
* How are review scores distributed?

### Delivery Operations

* How efficient is the delivery process?
* How frequently are orders delivered late?
* Which states experience the highest delivery delays?
* Does delivery performance impact customer satisfaction?

---

# Dataset

The project uses the **Brazilian E-Commerce Public Dataset by Olist**, containing approximately 99,000 orders placed between 2016 and 2018.

The dataset consists of multiple related tables:

| Table       | Description                         |
| ----------- | ----------------------------------- |
| Orders      | Order status and delivery lifecycle |
| Order Items | Product prices and freight costs    |
| Customers   | Customer location information       |
| Products    | Product categories and attributes   |
| Reviews     | Customer review scores              |
| Payments    | Payment methods and installments    |
| Geolocation | Geographic mapping information      |

---

# Tools & Technologies

### SQL Server

* Data Cleaning
* Data Validation
* Exploratory Analysis
* Business Logic Development

### Power BI

* Data Modeling
* DAX Measures
* Interactive Dashboards
* KPI Development
* Time Intelligence Analysis

### DAX

* Year-over-Year Growth
* Contribution Margin Calculations
* Delivery Performance Metrics
* Dynamic KPI Selection

---

# Project Workflow

```text
Data Collection
      ↓
Data Cleaning (SQL Server)
      ↓
Exploratory Data Analysis
      ↓
Business KPI Development
      ↓
Data Modeling (Power BI)
      ↓
DAX Calculations
      ↓
Dashboard Design
      ↓
Business Insights & Recommendations
```

---

# Data Quality & Problem Solving

One of the most valuable parts of this project involved resolving data quality issues before visualization.

### Missing Product Categories

During data validation, I discovered:

* 610 products with missing category information
* Affecting 1,603 actual customer orders

Instead of removing the records and losing revenue from the analysis, I investigated the issue and assigned these records to an **"Unknown"** category to preserve data integrity.

### Date Intelligence Challenge

The original purchase date contained timestamp values that caused inaccurate Year-over-Year calculations.

To resolve this:

* A dedicated Date Table was created
* Purchase timestamps were converted into clean date values
* Proper relationships were established to enable accurate time intelligence calculations

---

# Data Model

A star-schema model was implemented in Power BI to optimize performance and analytical flexibility.

### Fact Tables

* Order Items
* Orders

### Dimension Tables

* Customers
* Products
* Reviews
* Payments
* Date Table
* Geolocation

The model was designed to support profitability analysis, customer behavior analysis, and delivery performance tracking.

*(Insert Data Model Screenshot Here)*

---

# Dashboard 1 — Executive Overview

## Purpose

Provides a high-level view of business performance and profitability.

### KPIs

* Revenue
* Shipping Cost
* Contribution Margin
* Contribution Margin %
* Orders

### Key Visuals

* Monthly Contribution Margin Trend
* Contribution Margin by State
* Top 10 States by Contribution Margin
* Top 10 Product Categories by Selected KPI

### Advanced Feature

A dynamic KPI selector allows users to switch between:

* Revenue
* Contribution Margin
* Shipping Cost
* Margin %

This enables interactive ranking and comparison across categories.

---

# Dashboard 2 — Customer & Delivery Performance

## Purpose

Evaluates customer satisfaction and operational efficiency.

### KPIs

* Customers
* Average Review Score
* Late Deliveries
* Average Delivery Time
* Late Delivery %

### Key Visuals

* On-Time vs Late Deliveries Trend
* Review Score Distribution
* Orders by Status
* Delivery Time vs Review Score Analysis
* Top States by Late Deliveries

This dashboard helps connect operational performance directly to customer experience.

---

# Key Insights

### Financial Performance

* Revenue reached **R$13.59M**
* Revenue grew **205.3% YoY**
* Contribution Margin reached **R$11.34M**
* Margin % declined slightly despite revenue growth

### Product Performance

* Watches & Gifts and Health & Beauty generated the highest revenue
* High revenue does not always translate into the highest profitability

### Geographic Performance

* São Paulo generated the largest contribution margin
* Regional differences significantly impact profitability

### Customer Experience

* Average Review Score remained strong at **4.09 / 5**
* Most customers left positive reviews

### Delivery Operations

* Late Delivery Rate reached **7.87%**
* Late Deliveries increased significantly year-over-year
* States with high delivery delays require operational attention

### Business Relationship Identified

The analysis suggests a clear relationship between:

```text
Longer Delivery Time
          ↓
Lower Review Scores
          ↓
Reduced Customer Satisfaction
```

Delivery performance is therefore both an operational and customer experience metric.

---

# Recommendations

### Improve Logistics Performance

Investigate logistics partners and fulfillment processes in states with high delay rates.

### Focus on Profitability

Prioritize high-margin product categories rather than focusing solely on revenue generation.

### Monitor Delivery KPIs

Track late delivery rates alongside customer satisfaction metrics to identify service quality issues early.

### Expand Geographic Analysis

Evaluate late-delivery rates relative to order volume to better isolate underperforming regions.

---

# Skills Demonstrated

* SQL Data Cleaning
* Data Validation
* Exploratory Data Analysis
* Data Modeling
* DAX Development
* Time Intelligence
* KPI Design
* Dashboard Development
* Business Intelligence
* Data Storytelling
* Insight Generation
* Stakeholder-Focused Reporting

---

# Dashboard Screenshots

## Executive Overview Dashboard

<img width="779" height="470" alt="image" src="https://github.com/user-attachments/assets/eaf2e076-7901-4ca7-b73e-f5bedd2f7f6a" />


## Customer & Delivery Performance Dashboard

<img width="776" height="471" alt="image" src="https://github.com/user-attachments/assets/eee68d62-d5bc-4509-bbe9-410ae75efd11" />

powerbi link: https://drive.google.com/file/d/1TS-wCjJ3A_3y2_iLN2NDEpnudx2ou93k/view?usp=drive_link
---

## Author

**Jacqline Jackson-Igiebor**

Data Analyst | SQL | Power BI | Business Intelligence

This project demonstrates how financial, operational, and customer-focused analytics can be combined to provide a complete view of business performance and support data-driven decision-making.
