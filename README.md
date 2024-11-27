# Engeto-SQL-projekt
---
## Popis projektu

Tento projekt se zaměřuje na analýzu ekonomických ukazatelů v České republice, konkrétně 
na vztah mezi vývojem mezd, cen základních potravin a vývojem HDP. Cílem je zodpovědět 
klíčové výzkumné otázky, které zkoumají dostupnost základních potravin, změny v kupní síle 
obyvatel a souvislost mezi ekonomickými faktory v období let 2006 – 2018.

## Výzkumné otázky

**1.	Jaký je vývoj mezd v jednotlivých odvětvích během sledovaného období?**
	- • Cílem je zmapovat, jak se mzdy vyvíjely v průběhu let, a identifikovat 
	    trendy a odvětví s největším či nejmenším růstem mezd.

**2.	Kolik litrů mléka a kilogramů chleba bylo možné zakoupit za průměrnou mzdu 
	v prvním a posledním sledovaném období?**
	- • Zde se sleduje kupní síla obyvatel a její změna v průběhu let.

**3.	Která kategorie potravin zdražovala nejpomaleji, tj. měla nejnižší procentuální 
	meziroční nárůst cen?**
	- • Tato analýza identifikuje potraviny, jejichž ceny rostly nejstabilněji.

**4.	Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst 
	mezd (větší než 10 %)?**
	- • Cílem je určit období, ve kterém docházelo k narušení rovnováhy mezi růstem 
	    cen potravin a mzdami.

**5.	Má vývoj HDP vliv na změny ve mzdách a cenách potravin?**
	- • Analýza zkoumá, zda a jak růst HDP ovlivňuje ekonomické ukazatele, jako jsou 
	    mzdy a ceny potravin, ve stejném nebo následujícím roce.

## Struktura projektu

**•	Průvodní_zpráva_vyhodnocení_projektu.pdf**: Obsahuje popis výsledků na jednotlivé
	výzkumné otázky.

**•	Primární data**: 

	t_lucie_cernochova_project_sql_primary_final
	- vytvořená tabulka pro data mezd a cen potravin pro roky 2006 – 2018

	t_lucie_cernochova_project_sql_secondary_final
	- vytvořená tabulka pro dodatečná data o dalších evropských státech

**•	SQL dotazy**: Každá výzkumná otázka má samostatný SQL skript, který provádí analýzu. 

	Script_quary_1.sql
	Script_quary_2.sql
	Script_quary_3.sql
	Script_quary_4.sql
	Script_quary_5.sql

**•	Databázová struktura**: Obsahuje tabulky a pohledy, které propojují mzdy, 
	ceny potravin a HDP.