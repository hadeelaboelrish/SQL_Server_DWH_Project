# Project Overview

This project implements a full end-to-end Data Warehouse ETL pipeline using SQL Server and T-SQL, following the Medallion Architecture (Bronze → Silver → Gold).

The solution ingests raw data from CRM and ERP source systems, applies structured data cleansing and standardization, and delivers business-ready analytical datasets optimized for reporting and BI consumption.

The project reflects real-world data engineering practices, including batch processing, layered data modeling, data quality enforcement, and auditability.


# Architecture Overview – Medallion Model

# Bronze Layer – Raw Data Ingestion

Serves as the landing layer for all source data.

Stores data as received with no business transformations.

Loaded using high-performance BULK INSERT operations.

Full refresh strategy (TRUNCATE + LOAD).

Acts as a historical and traceable source for downstream layers.



# Silver Layer – Cleansed & Conformed Data

Applies data cleansing, normalization, and validation rules.

Resolves data quality issues:

Duplicate records

Invalid or malformed dates

Inconsistent categorical values


Standardizes reference data across CRM and ERP sources.

Adds audit metadata (dwh_create_date).

Produces conformed datasets ready for analytical modeling.


# Gold Layer – Business & Analytics Layer

Designed for business consumption and BI reporting.

Implements dimensional modeling using Fact and Dimension tables.

Aggregates and structures data to support analytical queries and KPIs.

Optimized for performance and usability.


Gold layer characteristics

Star schema modeling

Surrogate keys

Business-friendly naming conventions

Pre-calculated metrics and measures


Data Sources

CRM System

Customer master data

Product master data

Sales transaction details


ERP System

Customer demographic attributes

Customer location data

Product category hierarchy


All data is ingested from structured CSV files.




# ETL Workflow

# 1. Bronze Layer ETL

Implemented via:

bronze.load_bronze

Responsibilities

Truncate and reload raw tables

Bulk ingestion from CSV sources

Execution time tracking per table and batch

Centralized error handling using TRY/CATCH blocks



# 2.Silver Layer ETL

Implemented via:

silver.load_silver

Key Transformations

Deduplication using window functions (ROW_NUMBER)

Standardization of:

Gender and marital status codes

Product lines and categories

Country names


Validation and correction of date fields

Data consistency checks on sales metrics

Data enrichment and normalization

Addition of audit metadata



# 3.Gold Layer ETL

Implemented via:

gold.load_gold

Gold Layer Data Model

Dimension Tables

dim_customer

dim_product

dim_date

dim_location


Fact Tables

fact_sales



# Transformations

Surrogate key generation

Fact-to-dimension key mapping

Aggregation of sales metrics

Calculation of KPIs (revenue, quantity sold, average price)

Conformed dimensions reused across facts


# Data Quality & Governance

Enforced referential integrity between facts and dimensions

Standardized domain values across systems

Handled missing, invalid, and outlier values

Added audit columns for lineage and traceability

Ensured consistency between transactional and aggregated metrics




# Technologies & Tools

SQL Server

T-SQL

Stored Procedures

BULK INSERT

Window Functions

Medallion Architecture

Dimensional Modeling (Star Schema)


# Execution Steps

1. Create database schemas: bronze, silver, gold


2. Deploy Bronze tables and execute bronze.load_bronze


3. Deploy Silver tables and execute silver.load_silver


4. Deploy Gold tables and execute gold.load_gold


5. Connect BI tools to Gold layer for analytics
