--CLEANED AND LOADING bronze.crm_cust_info;

 USE DataWarehouse
 SELECT * FROM bronze.crm_cust_info

--STEP 1 CLEANING 



SELECT 
cst_id,
cst_key,
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname) as cst_lastname,
CASE WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'MARRIED'  
	 WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'SINGLE'   
END AS cst_marital_status,
CASE WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'MALE'  
	 WHEN UPPER(TRIM(cst_gndr)) = 'S' THEN 'FEMALW'  
	 ELSE 'NOT AVILABLE'
END AS cst_gndr,
cst_create_date
FROM (
SELECT
				*,
				ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
			FROM bronze.crm_cust_info
			WHERE cst_id IS NOT NULL
		) t
		WHERE flag_last = 1

-- RESULT: bronze.crm_cust_info CLEARED

	
-- STEP-2 LOADING CLEANED DATA INTO silver.crm_cust_info
	INSERT INTO  silver.crm_cust_info(
	cst_id,
    cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date)


SELECT
	cst_id,
	cst_key,
	TRIM(cst_firstname) AS cst_firstname,
	TRIM(cst_lastname) as cst_lastname,
	CASE WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'MARRIED'  
		 WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'SINGLE'   
	END AS cst_marital_status,
	CASE WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'MALE'  
		WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'FEMALE'  
		 ELSE 'NOT AVILABLE'
	END AS cst_gndr,
	cst_create_date
FROM bronze.crm_cust_info;


 SELECT  DISTINCT cst_gndr FROM silver.crm_cust_info
