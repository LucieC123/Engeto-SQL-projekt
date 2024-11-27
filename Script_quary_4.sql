-- 4.Existuje rok, ve kterém byl meziroční nárůst cen potravin 
-- výrazně vyšší než růst mezd (větší než 10 %)?

-- Vytvoření pohledu pro meziroční nárůst mezd podle let
CREATE OR REPLACE VIEW v_wage_year_comparison AS
SELECT 
	YEAR,
	round(sum(wage_growth),2) AS sum_wage_growth,
	round(avg(wage_growth), 2) AS avg_wage_growth,
	round(sum(wage_growth_percentage), 2) AS sum_percentage,
	round(avg(wage_growth_percentage), 2) AS avg_percentage
FROM v_year_on_year_comparisons AS yoyc 
GROUP BY YEAR;

-- Vytvoření pohledu pro meziroční průměrný nárůst cen potravin podle let      
CREATE VIEW v_price_year_comparison AS 
SELECT 
    curr_year.payroll_year AS current_year,
    prev_year.payroll_year AS previous_year,
    prev_year.avg_price_value AS previous_price,
    curr_year.avg_price_value AS current_price,
    ROUND(((curr_year.avg_price_value - prev_year.avg_price_value) / 
           NULLIF(prev_year.avg_price_value, 0)) * 100, 2) AS price_growth
FROM (
	SELECT -- Vnitřní poddotaz pro průměrnou cenu za každý rok
        payroll_year,
        AVG(price_value) AS avg_price_value
    FROM v_price_value 
    GROUP BY payroll_year
    ) AS curr_year
JOIN (
	SELECT
        payroll_year,
        AVG(price_value) AS avg_price_value
    FROM v_price_value 
    GROUP BY payroll_year
    ) AS prev_year
ON curr_year.payroll_year = prev_year.payroll_year + 1 
ORDER BY current_year;
        
   
-- Konečný dotaz pro určení, jestli byl růst cen potravin vyšší než růst mezd o více než 10 %
SELECT 
    price.current_year,
    wage.avg_percentage AS avg_wage_growth_percentage,
    price.price_growth AS food_price_growth_percentage,
    CASE 
        WHEN price.price_growth > wage.avg_percentage + 10 THEN 'Ano' 
        ELSE 'Ne'
    END AS 'growth > 10%'
FROM v_price_year_comparison AS price
JOIN v_wage_year_comparison AS wage
ON price.current_year = wage.year
ORDER BY price.current_year;
   

   
 
        