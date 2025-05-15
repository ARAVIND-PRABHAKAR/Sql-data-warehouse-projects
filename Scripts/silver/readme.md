# 📦 Data Loading and Cleaning Project

## 🧾 Overview

This project focuses on the **Extraction, Transformation, and Loading (ETL)** of data from various **ERP and CRM systems** into a cleaned and structured format using **SQL**. The goal is to **standardize**, **clean**, and **prepare datasets** for downstream use in **analytics, reporting, or data warehousing**.

---

## 📂 File Structure

| Script Name                               | Source System | Description                                                                 |
|------------------------------------------|----------------|-----------------------------------------------------------------------------|
| `CLEANED AND LOADING ERP_LOC_A101.sql`   | ERP            | Cleans and loads location data from ERP (e.g., warehouse or plant codes).   |
| `CLEANED AND LOADING ERP_PX_CAT_G1V2.sql`| ERP            | Processes and loads product category and classification data.               |
| `CLEANED AND LOADING ERP_CUST_AZ12.sql`  | ERP            | Cleans customer master data from the ERP system.                            |
| `CLEANED AND LOADING CRM_PRD_INFO.sql`   | CRM            | Loads cleaned product-related data from the CRM system.                     |
| `CLEANED AND LOADING CRM_SALE_DETAILS.sql`| CRM           | Transforms and loads CRM sales transaction data.                            |

---

## 🛠️ Steps Performed

### ✅ Cleaning
- Removed duplicates  
- Handled `NULL` values and inconsistent formatting  
- Standardized column naming conventions  

### 🔁 Transformation
- Derived new columns for classification and aggregation  
- Mapped codes to business-readable labels  
- Normalized categorical data  

### 💾 Loading
- Inserted into structured tables using `INSERT INTO` or `MERGE`  
- Maintained foreign key relationships where applicable  
- Verified row counts post-load for consistency  

---

## 🧰 Technologies Used
- SQL server 
- ERP/CRM Source Systems  
- Compatible with **SQL Server**, **PostgreSQL**, or any **standard RDBMS**  

---

## 📌 How to Use

1. Open each `.sql` file in your preferred SQL client (e.g., **DBeaver**, **SSMS**).
2. Execute scripts **in the recommended order** (starting with lookup tables).
3. Verify successful data loads using `SELECT` queries and row count checks.

---
