
-- QUALITY CHECK FOR bronze.crm_prd_info

USE DataWarehouse
SELECT * FROM bronze.crm_prd_info;

-- QUALITY ISSUES - 1 CHECKING DUPLICATES AND NULL VALUE 

SELECT prd_id ,

count(*) from bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*)>1 OR prd_id is NULL ;

-- RESULT: NO DUPLICATES and NULL VALUES IN prd_id
--prd_id is taken as primary key

SELECT count(*) from bronze.crm_prd_info  -- QUALITY ISSUES-2 
GROUP BY prd_key
HAVING COUNT(*)>1 OR prd_key is NULL;

-- RESULT: DUPLICATES FOUND
-- WE have LOTS OF INFORMATION ON prd_key cat_id and 
-- SPLITING INFORMATION USING SUBSTRING

SELECT 
REPLACE (SUBSTRING(prd_key,1,5),'-','_') as cat_id FROM  bronze.crm_prd_info;

 -- because  bronze.erp_px_cat_g1v2 contain same infomation AS ID
 -- COMPARING IT WITH  bronze.erp_px_cat_g1v2

 SELECT 
REPLACE (SUBSTRING(prd_key,1,5),'-','_') as cat_id FROM  bronze.crm_prd_info 
WHERE REPLACE (SUBSTRING(prd_key,1,5),'-','_') NOT IN 
(SELECT  DISTINCT id FROM bronze.erp_px_cat_g1v2);

-- RESULT : 7 RECORDS FOUND NOT IN bronze.erp_px_cat_g1v2

SUBSTRING(prd_key,7,LEN(prd_key)) as prd_key,

-- QUALITY ISSUES-2 DATA STANDARDIZATION AND CONSISTENCY

-- REMOVING UNNECESSARY SPACES AND REPLACING NULL WITH ZERO
SELECT
TRIM(prd_nm),
ISNULL (prd_cost,0) AS prd_cost,-- replacing null with 0
CASE  UPPER (TRIM(prd_line)) 
			WHEN'M' THEN 'Mountain'
			WHEN's' THEN 'Other Sales'
			WHEN'T' THEN 'Touring'
			WHEN'R' THEN 'Road'
	ELSE 'NOT AVILABLE'
END AS prd_line,
prd_start_dt,
prd_end_dt FROM bronze.crm_prd_info ;

/* if needed
SELECT DISTINCT * FROM bronze.erp_px_cat_g1v2; -- run this
-- CHECK bronze.erp_px_cat_g1v2 ID COLUM WITH cat_id*/


-- QUALITY ISSUE 3
-- CHECKING DATES 
SELECT prd_start_dt from bronze.crm_prd_info
 WHERE  prd_start_dt IS NULL ;

 -- TO CHECK WHETHER THERE END DATE LESS THAN START DATE
 -- END DATE MUST NOT BE EARLIER THAN START DATE

 SELECT
* from bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- RESULT : 200 RECORDS FOUND, FOUND DATE ISSUES
-- WE HAVE TO CHANGE IT AND DERIVE FROM START DATES

SELECT
    prd_id,
    REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id, 
    SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key,
    TRIM(prd_nm) AS prd_nm,
    ISNULL(prd_cost, 0) AS prd_cost, -- replacing null with 0
    CASE UPPER(TRIM(prd_line)) 
        WHEN 'M' THEN 'Mountain'
        WHEN 'S' THEN 'Other Sales'
        WHEN 'T' THEN 'Touring'
        WHEN 'R' THEN 'Road'
        ELSE 'NOT AVAILABLE'
    END AS prd_line,
     prd_start_dt,

    -- Fixing DATEADD usage with LEAD
    DATEADD(MONTH, -1, 
        LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)
    ) AS prd_end_dt

FROM bronze.crm_prd_info;



---- QUALITY CHECK FOR SILVER.crm_prd_info
SELECT prd_id ,

count(*) from silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*)>1 OR prd_id is NULL ;

--RESULT: NO RECORD

-- QUALITY ISSUES-2 

SELECT count(*) from silver.crm_prd_info  
GROUP BY prd_key
HAVING COUNT(*)>1 OR prd_key is NULL;

-- RESULT: NO DUPLICATES FOUND







/* if needed
SELECT DISTINCT * FROM bronze.erp_px_cat_g1v2; -- run this
-- CHECK bronze.erp_px_cat_g1v2 ID COLUM WITH cat_id
