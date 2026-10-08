-- =========================================================
-- File: 02_functions/B3_fn_calculate_tax.sql
-- Purpose: Function to compute tax based on salary bands
-- Author : Kevin (Student ID: 27780)
--
-- Tax bands (monthly salary):
--   <= 3000        ->  0%
--   3001 - 5000    -> 10%
--   5001 - 8000    -> 20%
--   > 8000         -> 30%
-- =========================================================

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION fn_calculate_tax (
   p_salary IN NUMBER
) RETURN NUMBER
IS
   v_tax NUMBER := 0;
BEGIN
   IF p_salary IS NULL OR p_salary < 0 THEN
      RAISE_APPLICATION_ERROR(-20010, 'Salary must be a positive number');
   END IF;

   IF p_salary <= 3000 THEN
      v_tax := 0;
   ELSIF p_salary <= 5000 THEN
      v_tax := p_salary * 0.10;
   ELSIF p_salary <= 8000 THEN
      v_tax := p_salary * 0.20;
   ELSE
      v_tax := p_salary * 0.30;
   END IF;

   RETURN ROUND(v_tax, 2);
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
      RETURN NULL;
END fn_calculate_tax;
/

-- ---------------------------------------------------------
-- Quick test
-- ---------------------------------------------------------
PROMPT ================================
PROMPT Testing fn_calculate_tax
PROMPT ================================
SELECT fn_calculate_tax(2500) AS tax_2500 FROM dual;
SELECT fn_calculate_tax(4500) AS tax_4500 FROM dual;
SELECT fn_calculate_tax(6000) AS tax_6000 FROM dual;
SELECT fn_calculate_tax(9000) AS tax_9000 FROM dual;

-- Test with employee data
SELECT emp_id, first_name, salary,
       fn_calculate_tax(salary) AS monthly_tax,
       salary - fn_calculate_tax(salary) AS net_salary
FROM employees
ORDER BY emp_id;
