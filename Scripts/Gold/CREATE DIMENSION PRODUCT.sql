CREATE VIEW gold.dim_product AS
SELECT 
ROW_NUMBER () OVER (ORDER BY pil.prd_start_dt,pil.prd_key) AS PRODUCT_NUMBER,
pil.prd_id AS PRODUCT_ID,
pil.prd_key AS PRODUCT_KEY,
pil.prd_nm AS PRODUCT_NAME,
pil.cat_id AS CATEGORY_ID,
COALESCE (px.CAT,'NOT AVILABLE') AS CATEGORY,	
COALESCE (px.SUBCAT,'NOT AVILABLE') AS SUB_CATEGORY,
pil.prd_cost AS PRDOUCT_COST,
pil.prd_line AS PRODUCT_LINE,
pil.prd_start_dt AS START_DATE,
COALESCE (px.MAINTENANCE,'NOT AVILABLE') AS MAINTENANCE
FROM SILVER.crm_prd_info pil
LEFT JOIN silver.erp_PX_CAT_G1V2 px
ON pil.cat_id = px.ID
where pil.prd_end_dt IS NULL






