-- CLEAN AND LOAD bronze.crm_cust_info


--QUALITY CHECK 1 - ELIMINATING DUPLICATE VALUES AND NULL  FOR PRIMARY KEY 
USE DataWarehouse

SELECT * FROM bronze.crm_cust_info

-- cst-id  WAS SELECTED AS PRIMARY KEY 

SELECT cst_id ,

count(*) from bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*)>1 OR cst_id is NULL -- TO FIND THE DUPLICATE VALUE AND NULL

select * FROM bronze.crm_cust_info
WHERE cst_id= 29466 -- TO CHECK QUALITY OF DATA AND TO SELECT WHICH COLUMN TO BE USED FOR RANKING

-- USED A CTE EXPRESSION FOR REMOVING DUPLICATE VALUE

WITH ranked AS 
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC)AS FLAG_LAST FROM bronze.crm_cust_info 
where cst_id is not null -- TO ELIMATE NULL VALUE
)
SELECT * FROM ranked
WHERE FLAG_LAST=1 

-- QUALITY CHECK 2
-- CHECKING UNWANTED SPACES IN STRING VALUES IN COLUMNS

select * FROM bronze.crm_cust_info ;-- TO KNOWN THE COLUMN NAME


--CHECK THE UNWANTED SPACES IN COLUMN cst_firstname

SELECT cst_firstname FROM  bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

--RESULT = FOUND

--CHECK THE UNWANTED SPACES IN COLUMN cst_lastname

SELECT cst_lastname FROM  bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

--RESULT = FOUND

--CHECK THE UNWANTED SPACES IN COLUMN cst_marital_status

SELECT cst_marital_status FROM  bronze.crm_cust_info
WHERE cst_marital_status != TRIM(cst_marital_status)

--RESULT = NOT FOUND (CLEAN DATA)

--CHECK THE UNWANTED SPACES IN COLUMN cst_gndr

SELECT cst_gndr FROM  bronze.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr)

--RESULT =  NOT FOUND (CLEAN DATA)

-- QUALITY CHECK 3

-- CHECKING CONSISTENCY OF VALUES IN LOW CARDINALITY COLUMN

-- LOW CARDINALITY--The column has very few unique values relative to the total number of rows.


SELECT DISTINCT cst_marital_status FROM bronze.crm_cust_info -- to know values present in column cst_martial_status
SELECT DISTINCT cst_gndr FROM bronze.crm_cust_info			 -- to know values present in cst_gndr


---------------------------------------------------------------
-- FIXING LOW CARDINALITY AND FIXING THE CONSISTENCY

 CASE  UPPER(TRIM(cst_marital_status)) 
		WHEN'M' THEN 'MARRIED'  
		WHEN  'S' THEN 'SINGLE'  
		ELSE 'NOT AVILABLE'
END AS cst_marital_status FROM bronze.crm_cust_info;


SELECT CASE  UPPER(TRIM(cst_gndr)) 
		WHEN'M' THEN 'MALE'  
		WHEN 'S' THEN 'FEMALE'  
		ELSE 'NOT AVILABLE'
END AS cst_gndr FROM bronze.crm_cust_info;
---------------------------------------------------------------





