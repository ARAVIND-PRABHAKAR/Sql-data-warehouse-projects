--- QUALITY CHECK
-- FING DUPLICATES AFTER JOINING
SELECT cst_id, count(*) from
(
SELECT 
ci.cst_id,
ci.cst_key,
ci.cst_firstname,
ci.cst_lastname,
ci.cst_marital_status,
ci.cst_gndr,
ci.cst_create_date,
ca.BDATE,
ca.GEN,
la.CID,
la.CNTRY
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_CUST_AZ12 ca
ON ci.cst_key = ca.CID
LEFT JOIN silver.erp_LOC_A101 la
ON ci.cst_key = la.CID
)t group by cst_id
having count(*) > 1;


-- NO DUPLICATES