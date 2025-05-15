
# 📂 Gold Layer - Data Warehouse Project

## 📘 Overview

The **Gold Layer** represents the business-level semantic model of the data warehouse. It consists of carefully structured **dimension** and **fact** tables designed to support reporting, business intelligence, and analytical queries. This layer simplifies data access for analysts and business users by providing clean, enriched, and human-readable data.

---

## 📐 Star Schema Components

### 🔹 1. `gold.dim_customers`
**Purpose:** Stores enriched customer profile information including demographic and geographic attributes.

| Column Name       | Data Type     | Description                                                                 |
|------------------|---------------|-----------------------------------------------------------------------------|
| customer_key      | INT           | Surrogate key uniquely identifying each customer                           |
| customer_id       | INT           | Unique numerical customer ID                                               |
| customer_number   | NVARCHAR(50)  | Alphanumeric identifier for tracking and referencing                       |
| first_name        | NVARCHAR(50)  | Customer’s first name                                                      |
| last_name         | NVARCHAR(50)  | Customer’s last name                                                       |
| country           | NVARCHAR(50)  | Country of residence                                                       |
| marital_status    | NVARCHAR(50)  | Marital status (e.g., 'Married', 'Single')                                 |
| gender            | NVARCHAR(50)  | Gender (e.g., 'Male', 'Female', 'n/a')                                     |
| birthdate         | DATE          | Date of birth (formatted as YYYY-MM-DD)                                    |
| create_date       | DATE          | Date and time when customer was created in the system                      |

---

### 🔹 2. `gold.dim_products`
**Purpose:** Stores product-related metadata and hierarchical product classification.

| Column Name         | Data Type     | Description                                                               |
|---------------------|---------------|---------------------------------------------------------------------------|
| product_key          | INT           | Surrogate key for product dimension                                       |
| product_id           | INT           | Internal product identifier                                               |
| product_number       | NVARCHAR(50)  | Alphanumeric product code                                                 |
| product_name         | NVARCHAR(50)  | Descriptive name of the product                                           |
| category_id          | NVARCHAR(50)  | Identifier for high-level product category                                |
| category             | NVARCHAR(50)  | Broad product category (e.g., 'Bikes')                                    |
| subcategory          | NVARCHAR(50)  | More detailed subcategory (e.g., 'Mountain Bikes')                        |
| maintenance_required | NVARCHAR(50)  | Indicates if maintenance is required ('Yes'/'No')                         |
| cost                 | INT           | Cost or base price of the product                                         |
| product_line         | NVARCHAR(50)  | Product series or collection                                              |
| start_date           | DATE          | Date when product became available for sale or use                        |

---

### 🔹 3. `gold.fact_sales`
**Purpose:** Contains transactional sales data used for revenue and performance analysis.

| Column Name    | Data Type     | Description                                                                 |
|----------------|---------------|------------------------------------------------------------------------------|
| order_number    | NVARCHAR(50)  | Unique sales order identifier                                               |
| product_key     | INT           | Foreign key linking to product dimension                                    |
| customer_key    | INT           | Foreign key linking to customer dimension                                   |
| order_date      | DATE          | Date when the order was placed                                              |
| shipping_date   | DATE          | Date when the order was shipped                                             |
| due_date        | DATE          | Date when the payment was due                                               |
| sales_amount    | INT           | Total sale value (e.g., 25 for $25)                                         |
| quantity        | INT           | Number of product units in the transaction                                  |
| price           | INT           | Price per unit of the product                                               |

---

## 🚀 Usage

These tables are optimized for:
- Dashboard reporting
- Business KPIs
- Trend analysis
- Customer and product segmentation

---

## 📎 Project Files
- `docs/data_catalog.md`: Data dictionary (as seen above)
- `scripts/`: SQL scripts for transformation and loading
- `tests/`: Validation scripts for schema and data checks

