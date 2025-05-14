

INSERT INTO  silver.crm_prd_info(
	prd_id,
	cat_id,
	prd_key ,
	prd_nm ,
	prd_cost ,
	prd_line ,
	prd_start_dt ,
	prd_end_dt )

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


SELECT * FROM silver.crm_prd_info



SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'crm_prd_info' 
  AND TABLE_SCHEMA = 'silver';
