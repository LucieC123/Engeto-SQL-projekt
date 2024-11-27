-- 2.Kolik je možné si koupit litrů mléka a kilogramů chleba za první 
-- a poslední srovnatelné období v dostupných datech cen a mezd?

SELECT 
    year_range.start_year,
    year_range.end_year,
    avg_wage_start.avg_wage AS avg_wage_start,
    avg_wage_end.avg_wage AS avg_wage_end,
    milk_2006.price_value AS milk_price_start,
    bread_2006.price_value AS bread_price_start,
    milk_2018.price_value AS milk_price_end,
    bread_2018.price_value AS bread_price_end,
    -- výpočet množství, které bylo možné koupit
    round((avg_wage_start.avg_wage / milk_2006.price_value), 0) AS milk_qty_start, -- mléko v roce 2006
    round((avg_wage_start.avg_wage / bread_2006.price_value), 0) AS bread_qty_start, -- chléb v roce 2006
    round((avg_wage_end.avg_wage / milk_2018.price_value), 0) AS milk_qty_end, -- mléko v roce 2018
    round((avg_wage_end.avg_wage / bread_2018.price_value), 0) AS bread_qty_end -- chléb v roce 2018
FROM -- začátek/konec sledovaného o období (2006-2018)
    (SELECT 
        MIN(payroll_year) AS start_year,
        MAX(payroll_year) AS end_year
     FROM t_lucie_cernochova_project_sql_primary_final) AS year_range
JOIN -- průměrná mzda za rok 2006
    (SELECT 
        payroll_year,
        round(AVG(value),2) AS avg_wage
     FROM t_lucie_cernochova_project_sql_primary_final
     GROUP BY payroll_year) AS avg_wage_start
     ON avg_wage_start.payroll_year = year_range.start_year
JOIN -- průměrná mzda za rok 2018
    (SELECT 
        payroll_year,
        round(AVG(value),2) AS avg_wage
     FROM t_lucie_cernochova_project_sql_primary_final
     GROUP BY payroll_year) AS avg_wage_end
     ON avg_wage_end.payroll_year = year_range.end_year
JOIN -- mléko za rok 2006
    (SELECT DISTINCT payroll_year, price_value
     FROM t_lucie_cernochova_project_sql_primary_final
     WHERE category_code = 114201
     GROUP BY category_code, payroll_year
     ) AS milk_2006
     ON milk_2006.payroll_year = year_range.start_year
JOIN -- chléb za rok 2006
    (SELECT DISTINCT payroll_year, price_value
     FROM t_lucie_cernochova_project_sql_primary_final
     WHERE category_code = 111301
     GROUP BY category_code, payroll_year
     ) AS bread_2006
     ON bread_2006.payroll_year = year_range.start_year
JOIN -- mléko za rok 2018
    (SELECT DISTINCT payroll_year, price_value
     FROM t_lucie_cernochova_project_sql_primary_final
     WHERE category_code = 114201
     GROUP BY category_code, payroll_year
     ) AS milk_2018
     ON milk_2018.payroll_year = year_range.end_year
JOIN -- chléb za rok 2018
    (SELECT DISTINCT payroll_year, price_value
     FROM t_lucie_cernochova_project_sql_primary_final
     WHERE category_code = 111301
     GROUP BY category_code, payroll_year
     ) AS bread_2018
     ON bread_2018.payroll_year = year_range.end_year;
    
 
    
    
