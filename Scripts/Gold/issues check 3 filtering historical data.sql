-- quality issue
-- filtering out historical data

SELECT 
pil.prd_id,
pil.cat_id,
pil.prd_key,
pil.prd_nm,
pil.prd_cost,
pil.prd_line,
pil.prd_start_dt
FROM SILVER.crm_prd_info pil
where pil.prd_end_dt IS NULL
