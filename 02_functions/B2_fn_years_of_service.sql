-- =========================================================
-- File: 02_functions/B2_fn_years_of_service.sql
-- Purpose: Function to compute years of service from hire_date
-- Author : Kevin (Student ID: 27780)
-- =========================================================

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION fn_years_of_service (
   p_hire_date IN DATE
) RETURN NUMBER
IS
   v_years NUMBER;
BEGIN
   IF p_hire_date IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002, 'Hire date cannot be null');
   END IF;

   IF p_hire_date > SYSDATE THEN
      RAISE_APPLICATION_ERROR(-20003, 'Hire date cannot be in the future');
   END IF;

   -- MONTHS_BETWEEN returns fractional months; divide by 12 and floor
   v_years := FLOOR(MONTHS_BETWEEN(SYSDATE, p_hire_date) / 12);
   RETURN v_years;
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
      RETURN NULL;
END fn_years_of_service;
/

-- ---------------------------------------------------------
-- Quick test
-- ---------------------------------------------------------
PROMPT ================================
PROMPT Testing fn_years_of_service
PROMPT ================================
SELECT fn_years_of_service(TO_DATE('2018-03-15','YYYY-MM-DD')) AS yrs_2018 FROM dual;
SELECT fn_years_of_service(TO_DATE('2022-09-10','YYYY-MM-DD')) AS yrs_2022 FROM dual;

-- Test with employee data
SELECT emp_id, first_name, hire_date,
       fn_years_of_service(hire_date) AS years_of_service
FROM employees
ORDER BY emp_id;
