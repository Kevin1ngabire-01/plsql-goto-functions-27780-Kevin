-- =========================================================
-- File: 02_functions/C1_fn_validate_payroll.sql
-- Purpose: Combined validator that uses the other functions
--          to validate an employee's payroll record.
-- Author : Kevin (Student ID: 27780)
-- =========================================================

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION fn_validate_payroll (
   p_emp_id IN NUMBER
) RETURN VARCHAR2
IS
   v_first_name   employees.first_name%TYPE;
   v_last_name    employees.last_name%TYPE;
   v_salary       employees.salary%TYPE;
   v_hire_date    employees.hire_date%TYPE;
   v_dept_id      employees.dept_id%TYPE;

   v_annual       NUMBER;
   v_years        NUMBER;
   v_tax          NUMBER;
   v_dept_name    VARCHAR2(50);

   v_status       VARCHAR2(400);
   v_flag         VARCHAR2(20) := 'OK';
BEGIN
   -- Fetch employee
   BEGIN
      SELECT first_name, last_name, salary, hire_date, dept_id
      INTO   v_first_name, v_last_name, v_salary, v_hire_date, v_dept_id
      FROM   employees
      WHERE  emp_id = p_emp_id;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RETURN 'INVALID: Employee ID ' || p_emp_id || ' not found';
   END;

   -- Compute derived values using other functions
   v_annual    := fn_annual_salary(v_salary);
   v_years     := fn_years_of_service(v_hire_date);
   v_tax       := fn_calculate_tax(v_salary);
   v_dept_name := fn_dept_name(v_dept_id);

   -- Validation rules
   IF v_salary < 3000 THEN
      v_flag := 'WARN-LOW-SALARY';
   ELSIF v_salary > 20000 THEN
      v_flag := 'WARN-HIGH-SALARY';
   ELSIF v_dept_name = 'UNKNOWN' THEN
      v_flag := 'WARN-NO-DEPT';
   ELSIF v_years < 0 THEN
      v_flag := 'ERROR-INVALID-HIRE-DATE';
   END IF;

   -- Build result string
   v_status := 'EMP ' || p_emp_id || ' (' || v_first_name || ' ' || v_last_name ||
               ') | Dept: ' || v_dept_name ||
               ' | Monthly: ' || v_salary ||
               ' | Annual: ' || v_annual ||
               ' | Years: ' || v_years ||
               ' | Tax: ' || v_tax ||
               ' | Status: ' || v_flag;

   RETURN v_status;

EXCEPTION
   WHEN OTHERS THEN
      RETURN 'ERROR: ' || SQLERRM;
END fn_validate_payroll;
/

-- ---------------------------------------------------------
-- Quick test
-- ---------------------------------------------------------
PROMPT ================================
PROMPT Testing fn_validate_payroll
PROMPT ================================
SELECT fn_validate_payroll(1001) AS v_1001 FROM dual;
SELECT fn_validate_payroll(1006) AS v_1006 FROM dual;
SELECT fn_validate_payroll(1008) AS v_1008 FROM dual;
SELECT fn_validate_payroll(9999) AS v_9999 FROM dual;   -- Should be INVALID
