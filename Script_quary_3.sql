-- 3.Která kategorie potravin zdražuje nejpomaleji 
-- (je u ní nejnižší percentuální meziroční nárůst)?

-- pomocné view s cenou zboží za jednotlivé roky
CREATE VIEW v_price_value AS 
SELECT 
	primary_table.category_code,
	price_category.name,
	primary_table.payroll_year,
	primary_table.price_value 
FROM t_lucie_cernochova_project_sql_primary_final AS primary_table
JOIN czechia_price_category AS price_category 
ON primary_table.category_code = price_category.code 
GROUP BY primary_table.payroll_year, primary_table.category_code ;


-- vysledná tabulka s celkovým meziročním součtem 
SELECT 
	name,
	round(SUM(price_growth),2) AS total_yearly_growth, -- suma meziročního srovnání pro každou kategorii
	round(AVG(price_growth),2) AS avg_yearly_growth -- průměrný meziroční nárůst pro každou kategorii
FROM 
	(SELECT 
		vpv.category_code,
		vpv.name,
		vpv.payroll_year AS year,
		vpv.price_value,
		vpv2.payroll_year + 1 AS prev_year,
		round((vpv.price_value - vpv2.price_value) / NULLIF(vpv2.price_value, 0) * 100, 2) AS price_growth -- meziroční výpočet pro jednotlivé zboží
	FROM v_price_value AS vpv 
	JOIN v_price_value AS vpv2 
	ON vpv.category_code = vpv2.category_code 
	AND vpv.category_code IS NOT NULL 
	AND vpv.payroll_year = vpv2.payroll_year + 1) AS yearly_growth
GROUP BY name
ORDER BY total_yearly_growth;




