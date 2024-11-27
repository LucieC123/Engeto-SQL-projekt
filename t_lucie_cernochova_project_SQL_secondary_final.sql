CREATE TABLE t_lucie_cernochova_project_SQL_secondary_final AS 
SELECT 
	countries.*,
	economies.`year`,
	economies.GDP,
	economies.gini,
	economies.taxes
FROM countries AS countries
JOIN economies AS economies
ON countries.country = economies.country 
AND countries.continent LIKE '%Europe%';