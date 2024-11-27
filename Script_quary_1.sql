-- Vypracování:
-- 1.Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

-- View - Min/max mzdy dle zkoumaných let.
CREATE VIEW v_min_max_payroll AS 
SELECT
	payroll_year,
	industry_branch_name,
	min(value) AS min_value,
	max(value) AS max_value
FROM t_lucie_cernochova_project_sql_primary_final AS tlcpspf
WHERE value_type_code = 5958 -- Průměrná hrubá mzda na zaměstnance
GROUP BY industry_branch_name, payroll_year;

-- View - Meziroční percentuální růst mezd v jednotlivých odvětvích.
CREATE VIEW v_year_on_year_comparisons AS 
SELECT 
    current_year.industry_branch_name,
    current_year.payroll_year AS year,
    previous_year.max_value AS previous_year_max,
    current_year.max_value AS current_year_max,
    (current_year.max_value - previous_year.max_value) AS wage_growth,
    round((current_year.max_value - previous_year.max_value) / NULLIF(previous_year.max_value, 0) * 100, 2) AS wage_growth_percentage
FROM 
    v_min_max_payroll AS current_year
JOIN 
    v_min_max_payroll AS previous_year
ON 
    current_year.industry_branch_name = previous_year.industry_branch_name 
    AND current_year.payroll_year = previous_year.payroll_year + 1
ORDER BY 
    current_year.industry_branch_name,
    current_year.payroll_year;

-- Srovnání odvětví dle min/max procentualního rozdílu mezd.    
SELECT 
	industry_branch_name, 
	min(wage_growth_percentage),
	max(wage_growth_percentage)
FROM v_year_on_year_comparisons AS yoyc 
GROUP BY industry_branch_name 
ORDER BY min(wage_growth_percentage),
		max(wage_growth_percentage);

-- Výpočet celkového průměrného růstu mezd.
SELECT 
	AVG(wage_growth) AS avg_wage_growth
FROM v_year_on_year_comparisons AS yoyc;


	
	
	