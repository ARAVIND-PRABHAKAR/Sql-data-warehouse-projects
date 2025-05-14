-- QUANTITY CHECK -4
--FINDING DUPLICATES

select prd_key, count(*) from
(
SELECT 
pil.prd_id,
pil.cat_id,
pil.prd_key,
pil.prd_nm,
pil.prd_cost,
pil.prd_line,
px.CAT,
px.SUBCAT,
px.MAINTENANCE,
pil.prd_start_dt
FROM SILVER.crm_prd_info pil
LEFT JOIN silver.erp_PX_CAT_G1V2 px
ON pil.cat_id = px.ID
where pil.prd_end_dt IS NULL
)t group by prd_key
having count(*) > 1

-- NO DUPLICATES FOUND

