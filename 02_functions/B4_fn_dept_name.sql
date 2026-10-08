-- =========================================================
-- File: 02_functions/B4_fn_dept_name.sql
-- Purpose: Function to look up department name by dept_id
-- Author : Kevin (Student ID: 27780)
-- =========================================================

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION fn_dept_name (
   p_dept_id IN NUMBER
) RETURN VARCHAR2
IS
   v_dept_name departments.dept_name%TYPE;
BEGIN
   IF p_dept_id IS NULL THEN
      RETURN 'UNKNOWN';
   END IF;

   SELECT dept_name
   INTO   v_dept_name
   FROM   departments
   WHERE  dept_id = p_dept_id;

   RETURN v_dept_name;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RETURN 'UNKNOWN';
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
      RETURN NULL;
END fn_dept_name;
/

-- ---------------------------------------------------------
-- Quick test
-- ---------------------------------------------------------
PROMPT ================================
PROMPT Testing fn_dept_name
PROMPT ================================
SELECT fn_dept_name(10) AS dept_10 FROM dual;
SELECT fn_dept_name(30) AS dept_30 FROM dual;
SELECT fn_dept_name(99) AS dept_99 FROM dual;   -- Should return UNKNOWN

-- Test with employee data
SELECT emp_id, first_name, dept_id,
       fn_dept_name(dept_id) AS department
FROM employees
ORDER BY emp_id;
