CREATE VIEW gold.dim_customer AS
SELECT 
ROW_NUMBER() OVER (ORDER BY cst_id ) AS CUSTOMER_KEY,
ci.cst_id AS CUSTOMER_ID,
ci.cst_key AS CUSTOMER_NUMBER,
ci.cst_firstname AS FIRST_NAME,
ci.cst_lastname AS LAST_NAME,
ci.cst_marital_status AS MARTIAL_STATUS,
CASE WHEN ci.cst_gndr != 'NOT AVILABLE' THEN ci.cst_gndr 
	 ELSE COALESCE( ca.GEN ,'NOT AVILABLE')
	 END AS GENDER,
ci.cst_create_date AS CREATE_DATE,
ca.BDATE AS BIRTH_DATE,
la.CNTRY AS COUNTRY
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_CUST_AZ12 ca
ON ci.cst_key = ca.CID
LEFT JOIN silver.erp_LOC_A101 la
ON ci.cst_key = la.CID

