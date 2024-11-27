CREATE TABLE t_lucie_cernochova_project_SQL_primary_final AS
SELECT 
    payroll.*,
    industry_branch.name AS industry_branch_name,
    calculation.name AS calculation_name,
    unit.name AS unit_name,
    value_type.name AS value_type_name,
    price.value AS price_value,
    price.category_code AS category_code,
    price.region_code AS region_code
FROM 
    czechia_payroll AS payroll 
JOIN 
    czechia_payroll_industry_branch AS industry_branch
    ON payroll.industry_branch_code = industry_branch.code
JOIN 
    czechia_payroll_calculation AS calculation
    ON payroll.calculation_code = calculation.code
JOIN 
    czechia_payroll_unit AS unit 
    ON payroll.unit_code = unit.code 
JOIN 
    czechia_payroll_value_type AS value_type 
    ON payroll.value_type_code = value_type.code
    AND value_type.code = 5958
JOIN 
	czechia_price AS price 
	ON payroll.payroll_year = YEAR(price.date_from);