CREATE VIEW gold.fact_sales AS
SELECT
sd.sls_ord_num AS ORDER_NUMBER,
pd.PRODUCT_KEY,
cu.CUSTOMER_KEY,
sd.sls_order_dt AS ORDER_DATE,
sd.sls_ship_dt AS SHIPPING_DATE,
sd.sls_due_dt AS DUE_DATE,
sd.sls_sales AS SALES,
sd.sls_quantity AS QUANTITY,
sd.sls_price AS PRICE
from silver.crm_sales_details sd
LEFT JOIN gold.dim_customer cu
ON sd.sls_cust_id = cu.customer_id
LEFT JOIN gold.dim_product pd
ON sd.sls_prd_key = pd.product_key