-- 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? 
-- Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na 
-- cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

-- Vytvoření pohledu pro meziroční nárůst HDP podle let
CREATE OR REPLACE VIEW v_gdp_year_comparison AS 
SELECT 
    curr_year.year AS current_year,
    prev_year.year AS previous_year,
    prev_year.avg_gdp AS previous_gdp,
    curr_year.avg_gdp AS current_gdp,
    ROUND(((curr_year.avg_gdp - prev_year.avg_gdp) / 
           NULLIF(prev_year.avg_gdp, 0)) * 100, 2) AS gdp_growth
FROM (
	SELECT -- Vnitřní poddotaz pro průměrné HDP za každý rok
        year,
        AVG(gdp) AS avg_gdp
    FROM economies AS e 
    WHERE country LIKE '%Czech Republic%'
    AND gdp IS NOT NULL 
    GROUP BY YEAR
    ) AS curr_year
JOIN (
	SELECT
        year,
        AVG(gdp) AS avg_gdp
    FROM economies AS e 
    WHERE country LIKE '%Czech Republic%'
    AND gdp IS NOT NULL 
    GROUP BY YEAR
    ) AS prev_year
ON curr_year.year = prev_year.year + 1 
ORDER BY current_year;

-- Sloučení meziročních změn HDP s růstem mezd a cen potravin
SELECT 
    gdp.current_year + 1 AS gdp_year,
    gdp.gdp_growth AS gdp_growth,
    wage.avg_percentage AS wage_growth,
    food.price_growth AS food_price_growth,
    CASE 
        WHEN gdp.gdp_growth > 5 AND (wage.avg_percentage > 10 OR food.price_growth > 10) THEN 'Ano'
        ELSE 'Ne'
    END AS significant_correlation
FROM v_gdp_year_comparison AS gdp
JOIN v_wage_year_comparison AS wage 
    ON gdp.current_year + 1 = wage.year
JOIN v_price_year_comparison AS food 
    ON gdp.current_year + 1 = food.current_year
ORDER BY gdp.current_year;


