
# 🏗️ SQL Data Warehouse Project: CRM & ERP Data Integration
Building a Modern data warehouse with SQL server ,including ETL processes ,data modeling, and analytics



## 📘 Project Overview

This project demonstrates a classic **multi-layered data warehouse** architecture using SQL Server. It integrates CRM and ERP data sources into a centralized warehouse using a **Bronze → Silver → Gold** layering approach.

![Data Flow Diagram](A_flow_diagram_in_the_image_illustrates_a_data_pro.png)

---

## 📂 Project Structure

```
├── CREATE DDL BRONZE.sql         # DDL script to create Bronze Layer tables
├── DEVELOP SQL LOAD SCRIPT.sql  # Stored procedure to load data into Bronze Layer
├── A_flow_diagram_*.png         # High-quality architecture image
└── README.md                    # Project documentation
```

---

## 🔄 Data Architecture

### 1. **Bronze Layer**: Raw Ingestion
Stores unprocessed data directly loaded from CRM and ERP source files.

Tables:
- `bronze.crm_cust_info`
- `bronze.crm_prd_info`
- `bronze.crm_sales_details`
- `bronze.erp_cust_az12`
- `bronze.erp_loc_a101`
- `bronze.erp_px_cat_g1v2`

### 2. **Silver Layer**: Cleaned & Transformed
Data is cleaned, filtered, and structured for better querying (not covered in scripts yet — future scope).

### 3. **Gold Layer**: Star Schema (Business-Ready)
Final model optimized for BI tools and reporting with fact and dimension tables:
- `fact_sales`, `dim_customers`, `dim_products`, etc.

---

## ⚙️ How to Use

1. **Create Tables**  
   Run `CREATE DDL BRONZE.sql` to create the necessary tables in the `bronze` schema.

2. **Load Data**  
   Execute `bronze.load_bronze` stored procedure from `DEVELOP SQL LOAD SCRIPT.sql` to bulk insert CSVs into Bronze tables.

> 🔧 **Note:** Update the file paths in `BULK INSERT` statements to match your local CSV directory.

---

## 🧪 Future Enhancements

- Add Silver and Gold layer transformations
- Implement incremental loading logic
- Add tests and logging
- Create Power BI dashboards

---

## 👨‍💻 Author

Aravind Prabhakar A

---

## 📜 License

This project is open source and available under the [MIT License](LICENSE).

