-- =========================================================
-- File: 03_tests/B5_functions_in_select.sql
-- Purpose: Demonstrate all custom functions used inside
--          a single SQL SELECT statement.
-- Author : Kevin (Student ID: 27780)
-- =========================================================

SET SERVEROUTPUT ON;
SET LINESIZE 200;
SET PAGESIZE 50;

PROMPT ================================================================
PROMPT  B5 - Using Custom PL/SQL Functions Inside SQL
PROMPT ================================================================

-- ---------------------------------------------------------
-- All functions used in one SELECT
-- ---------------------------------------------------------
SELECT
   emp_id,
   first_name || ' ' || last_name     AS employee,
   salary                              AS monthly_salary,
   fn_annual_salary(salary)            AS annual_salary,
   fn_years_of_service(hire_date)      AS years_of_service,
   fn_calculate_tax(salary)            AS monthly_tax,
   salary - fn_calculate_tax(salary)   AS net_salary,
   fn_dept_name(dept_id)               AS department
FROM employees
ORDER BY emp_id;

PROMPT
PROMPT ================================================================
PROMPT  B5 - Payroll validation using fn_validate_payroll
PROMPT ================================================================
SELECT emp_id,
       fn_validate_payroll(emp_id) AS payroll_status
FROM employees
ORDER BY emp_id;

PROMPT
PROMPT B5 test complete.
