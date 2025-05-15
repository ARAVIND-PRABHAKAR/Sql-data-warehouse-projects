
# 🏗️ SQL Data Warehouse Project: CRM & ERP Data Integration
Building a Modern data warehouse with SQL server ,including ETL processes ,data modeling, and analytics


## 📘 Overview
This project demonstrates an end-to-end **Data Warehouse Architecture** integrating data from **ERP and CRM systems** into a centralized SQL-based warehouse using a layered ETL approach. The project includes:

- Bronze Layer: Raw data ingestion
- Silver Layer: Cleaned and transformed data
- Gold Layer: Star schema modeling (fact and dimension tables)

The objective is to provide analysts with business-ready, reliable, and query-efficient data.

---

## 📐 Data Architecture

### 🔸 Bronze Layer: Raw Ingestion
This is the raw data ingestion layer where source data from CRM and ERP systems is loaded with minimal transformation.

**Scripts:**  
- `CREATE DDL BRONZE.sql`: Creates schema and tables in the `bronze` layer.
- `DEVELOP SQL LOAD SCRIPT.sql`: Loads data using `BULK INSERT` into `bronze` tables.

**Tables Included:**
- `crm_sales_details`, `crm_cust_info`, `crm_prd_info`
- `erp_cust_az12`, `erp_loc_a101`, `erp_px_cat_g1v2`

### 🔸 Silver Layer: Cleaned/Transformed (WIP)
This layer is intended for cleaned, deduplicated, and normalized data. Not included in scripts but represents a future enhancement.

### 🔸 Gold Layer: Star Schema Modeling
Provides business-friendly, enriched data in a dimensional model.

**Tables:**  
#### `gold.dim_customers`
- Enriched customer profile with demographic and geographic data.

#### `gold.dim_products`
- Product metadata and classification hierarchy.

#### `gold.fact_sales`
- Transactional sales data for KPIs and revenue tracking.

**Key Benefits:**
- Easy integration with BI tools
- Faster analytical queries
- Logical structure for reporting

---

## 🚀 Data Loading & Cleaning Project

### 🧾 Focus
The ETL process involves:
- Cleaning: Deduplication, NULL handling, standardization
- Transformation: Label mapping, categorization
- Loading: Into structured tables maintaining relationships

**Scripts:**
| Script Name                                 | Source | Description |
|--------------------------------------------|--------|-------------|
| `CLEANED AND LOADING ERP_LOC_A101.sql`     | ERP    | Loads location data |
| `CLEANED AND LOADING ERP_PX_CAT_G1V2.sql`  | ERP    | Loads product categories |
| `CLEANED AND LOADING ERP_CUST_AZ12.sql`    | ERP    | Loads customer master data |
| `CLEANED AND LOADING CRM_PRD_INFO.sql`     | CRM    | Loads product info |
| `CLEANED AND LOADING CRM_SALE_DETAILS.sql` | CRM    | Loads sales transaction data |

---

## 🧰 Technologies Used
- SQL Server
- ERP and CRM Source Systems
- Compatible with PostgreSQL and any RDBMS
- Draw.io (for data flow diagrams)

---

## 🗂️ File Structure

```
├── README.md                           # Project documentation
├── CREATE DDL BRONZE.sql              # DDL script for bronze tables
├── DEVELOP SQL LOAD SCRIPT.sql        # ETL procedure for Bronze Layer
├── CLEANED AND LOADING *.sql          # Transformation scripts for Gold layer
├── data_flow_diagram.drawio           # Editable diagram of data flow
├── A_flow_diagram.png                 # Visual architecture (PNG)
└── docs/data_catalog.md               # Optional metadata and descriptions
```

---

## 📎 Usage

1. Open scripts in SSMS or DBeaver.
2. Create the bronze schema using DDL.
3. Load data via the ETL procedure (`load_bronze`).
4. Apply cleaning and transformation scripts.
5. Validate using `SELECT COUNT(*)` and cross-check relationships.

---

## 📊 Use Cases

- Dashboard creation (Power BI, Tableau)
- Customer/product segmentation
- KPI tracking (sales performance, delivery timelines)
- Trend analysis and forecasting

---

## 👨‍💻 Author

**Aravind Prabhakar A**

---

## 📜 License

This project is licensed under the MIT License.

