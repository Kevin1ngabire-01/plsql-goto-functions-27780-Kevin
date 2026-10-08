-- =========================================================
-- File: 02_functions/B1_fn_annual_salary.sql
-- Purpose: Function to calculate annual salary from monthly
-- Author : Kevin (Student ID: 27780)
-- =========================================================

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION fn_annual_salary (
   p_monthly_salary IN NUMBER
) RETURN NUMBER
IS
   v_annual NUMBER;
BEGIN
   IF p_monthly_salary IS NULL OR p_monthly_salary < 0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Salary must be a positive number');
   END IF;

   v_annual := p_monthly_salary * 12;
   RETURN v_annual;
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
      RETURN NULL;
END fn_annual_salary;
/

-- ---------------------------------------------------------
-- Quick test
-- ---------------------------------------------------------
PROMPT ================================
PROMPT Testing fn_annual_salary
PROMPT ================================
SELECT fn_annual_salary(4500) AS annual_from_4500 FROM dual;
SELECT fn_annual_salary(7200) AS annual_from_7200 FROM dual;

-- Test with employee data
SELECT emp_id, first_name, salary,
       fn_annual_salary(salary) AS annual_salary
FROM employees
ORDER BY emp_id;
