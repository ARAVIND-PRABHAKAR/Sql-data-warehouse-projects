-- QUALITY CHECK FOR bronze.crm.sales_details

-- cleaning bronze.crm_sales_details

-- QUALITY ISSUES -1 checking un wanted space

SELECT * FROM bronze.crm_sales_details
where sls_ord_num != TRIM(sls_ord_num);
--RESULT: NO RECORDS FOUND


SELECT * FROM bronze.crm_sales_details
-- COMPARING WITH OTHER TABLE TO FIND ANY COMMON COLUMNS
WHERE sls_cust_id NOT IN ( SELECT cst_id from silver.crm_cust_info);

-- RESULT : ALL RECORD ARE COMMON IN BOTH TABLE

SELECT * FROM bronze.crm_sales_details
-- COMPARING WITH OTHER TABLE TO FIND ANY COMMON COLUMNS
WHERE sls_prd_key NOT IN ( SELECT prd_key from silver.crm_prd_info);
-- RESULT : ALL RECORD ARE COMMON IN BOTH TABLE
-- NO ISSUES- WE CAN CONNECT BOTH TABLE WITH THIS TABLE

-- QUALITY ISSUES 3
-- CHECK FOR INVALID DATES
SELECT NULLIF (sls_order_dt, 0)sls_order_dt
FROM bronze.crm_sales_details
WHERE  sls_order_dt <=0
OR LEN(sls_order_dt) !=8 
OR sls_order_dt >20500101
OR sls_order_dt<19000101;
-- RESULT : 19 RECORDS FOUND
-- CLEANING DATA
SELECT  sls_order_dt,
CASE WHEN sls_order_dt <= 0 OR LEN(sls_order_dt) !=8 THEN NULL
	  ELSE CAST (CAST (sls_order_dt AS VARCHAR)AS DATE)
	  END AS sls_new_order_dt
FROM bronze.crm_sales_details

--RESULT : DATA CLEANED

----------TO CHECK AGAIN THE CONDITION IS SATISFIED----
SELECT  sls_order_dt,
CASE WHEN sls_order_dt <= 0 OR LEN(sls_order_dt) !=8 THEN NULL
	  ELSE CAST (CAST (sls_order_dt AS VARCHAR)AS DATE)
	  END AS sls_new_order_dt
FROM bronze.crm_sales_details
 WHERE  sls_order_dt <=0
OR LEN(sls_order_dt) !=8 
OR sls_order_dt >20500101
OR sls_order_dt<19000101 ;

-- RESULT: REPLACE ZERO'S WITH NULL AND LENGTH EQUAL THAN 8  WITH NULL

-- CHECKING QUALITY ISSUES WITH sls_ship_dt

SELECT NULLIF (sls_ship_dt, 0)sls_ship_dt
FROM bronze.crm_sales_details
WHERE  sls_ship_dt <=0
OR LEN(sls_ship_dt) !=8 
OR sls_ship_dt >20500101
OR sls_ship_dt <19000101;

-- RESULT : 0
-- CLEANING DATA--
SELECT  sls_ship_dt,
CASE WHEN sls_ship_dt <= 0 OR LEN(sls_ship_dt) !=8 THEN NULL
	  ELSE CAST (CAST (sls_ship_dt AS VARCHAR)AS DATE)
	  END AS sls_new_ship_dt
FROM bronze.crm_sales_details
--RESULT : DATA CLEANED

----------TO CHECK AGAIN THE CONDITION IS SATISFIED----
SELECT  sls_ship_dt,
CASE WHEN sls_ship_dt <= 0 OR LEN(sls_ship_dt) !=8 THEN NULL
	  ELSE CAST (CAST (sls_ship_dt AS VARCHAR)AS DATE)
	  END AS sls_new_ship_dt
FROM bronze.crm_sales_details
 WHERE  sls_ship_dt<=0
OR LEN(sls_ship_dt) !=8 
OR sls_ship_dt >20500101
OR sls_ship_dt <19000101 ;

-- RESULT : 0

-- CHECKING QUALITY ISSUES WITH sls_ship_dt

SELECT NULLIF (sls_ship_dt, 0)sls_ship_dt
FROM bronze.crm_sales_details
WHERE  sls_ship_dt <=0
OR LEN(sls_ship_dt) !=8 
OR sls_ship_dt >20500101
OR sls_ship_dt <19000101
OR sls_due_dt < sls_ship_dt ;

-- RESULT : 0

-- DATA CONSISTENCY AND FIXING LOW CARDINALITY

-- CHECKING ANY ZERO VALES OR NULL VALES OR NEGATIVE VALUE IN sls_sales,sls_price,sls_quantity
-- CHECKING RELATION BETWEEN sls_price,sls_quantity,sls_sales
-- sls_sales=sls_price X sls_quantity


SELECT DISTINCT * FROM  bronze.crm_sales_details
WHERE sls_price IS NULL OR sls_price <=0
OR sls_quantity IS NULL OR sls_quantity <=0
OR sls_sales IS NULL OR sls_sales <=0 
OR sls_SALES != sls_quantity * sls_price
ORDER  BY sls_sales,sls_quantity,sls_price;

-- RESULT: 35 RECORDS FOUND
-- CHECKING RELATION BETWEEN sls_price,sls_quantity,sls_sales
-- sls_sales=sls_price X sls_quantity

--FIXING ISSUES

SELECT

sls_sales as sls_old_sales,
sls_quantity,
sls_price as sls_old_price,
CASE WHEN sls_sales IS NULL OR sls_sales <=0 OR sls_sales != sls_quantity * abs(sls_price)
	 THEN sls_quantity * abs(sls_price)
	 ELSE sls_sales
END AS sls_sales,

CASE WHEN sls_price IS NULL OR sls_price <=0 
	 THEN sls_sales / NULLIF(sls_quantity,0)
	 ELSE sls_price
END AS sls_price
FROM bronze.crm_sales_details
ORDER  BY sls_old_sales,sls_quantity,sls_old_price ;

-- RESULT : DATA CLEANED


--- QUALITY CHECK FOR silver.crm_sales_details

SELECT * FROM silver.crm_sales_details
where sls_ord_num != TRIM(sls_ord_num);



SELECT * FROM silver.crm_sales_details
-- COMPARING WITH OTHER TABLE TO FIND ANY COMMON COLUMNS
WHERE sls_cust_id NOT IN ( SELECT cst_id from silver.crm_cust_info);


SELECT * FROM silver.crm_sales_details
-- COMPARING WITH OTHER TABLE TO FIND ANY COMMON COLUMNS
WHERE sls_prd_key NOT IN ( SELECT prd_key from silver.crm_prd_info);












