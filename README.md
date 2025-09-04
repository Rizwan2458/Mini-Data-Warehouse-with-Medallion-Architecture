# Mini Data Warehouse with Medallion Architecture

This project demonstrates the design and implementation of a Mini Data Warehouse using the Medallion Architecture (Bronze, Silver, Gold) in PostgreSQL.  
It covers raw data ingestion, data cleaning and transformation, dimensional modeling, and quality checks for data consistency and integrity.

---

## Architecture Overview

### Bronze Layer
- Stores raw data ingested from CSV files.
- Acts as a landing zone without transformations.

### Silver Layer
- Cleanses, standardizes, and enriches data.
- Business logic applied via stored procedures.
- Ensures data consistency and validity.

### Gold Layer
- Contains fact and dimension tables/views.
- Optimized for analytics and reporting.
- Supports surrogate keys and referential integrity.

---

## Key Features
- Automated ETL Pipeline with stored procedures for loading Silver Layer.
- Normalization and standardization of customer, product, and sales data.
- Dimensional modeling (Fact and Dimension tables) for analytical queries.
- Quality Checks across Silver and Gold layers:
  - Null/duplicate key checks
  - Data standardization validation
  - Referential integrity enforcement
  - Invalid date/order detection
- Surrogate Key Generation for analytical dimensions.

---

## Tech Stack
- PostgreSQL – Data warehouse, transformations, stored procedures, views.
- SQL – ETL, data modeling, quality checks.

---

# Project Structure

├── bronze/
│ ├── load_customers.sql
│ ├── load_products.sql
│ └── load_sales.sql
│
├── silver/
│ ├── transform_customers.sql
│ ├── transform_products.sql
│ └── transform_sales.sql
│
├── gold/
│ ├── dim_customers.sql
│ ├── dim_products.sql
│ └── fact_sales.sql
│
├── quality_checks/
│ ├── bronze_quality_checks.sql
│ ├── silver_quality_checks.sql
│ └── gold_quality_checks.sql
│
├── procedures/
│ ├── sp_load_bronze.sql
│ ├── sp_transform_silver.sql
│ └── sp_load_gold.sql
│
├── data/
│ ├── cust_info.csv
│ ├── prod_info.csv
│ └── sales_info.csv
│
├── README.md
└── LICENSE

---

## How to Run

1. Set up PostgreSQL and create a database (`datawarehouse`).
2. Create Schemas:
   ```sql
   CREATE SCHEMA bronze;
   CREATE SCHEMA silver;
   CREATE SCHEMA gold;
3. Load Raw Data into the Bronze Layer (using COPY or \copy in psql).
4. Run Silver Layer Procedure:
   ```sql
   CALL silver.load_silver();
5. Create Gold Layer Views for facts and dimensions.
6. Run Quality Checks scripts to validate data integrity.
