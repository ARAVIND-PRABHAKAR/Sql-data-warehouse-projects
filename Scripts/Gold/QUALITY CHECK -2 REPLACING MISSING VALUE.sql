-- QUALITY CHECK -2
--REPLACING MISSING VALUE
SELECT 
DISTINCT
ci.cst_gndr,
ca.GEN,
CASE WHEN ci.cst_gndr != 'NOT AVILABLE' THEN ci.cst_gndr -- CRM IS THE MASTER SOURCE
	 ELSE COALESCE( ca.GEN ,'NOT AVILABLE')
	 END AS NEW_GEN
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_CUST_AZ12 ca
ON ci.cst_key = ca.CID
LEFT JOIN silver.erp_LOC_A101 la
ON ci.cst_key = la.CID
ORDER BY 1,2

-- RSEULT: REPLACED

