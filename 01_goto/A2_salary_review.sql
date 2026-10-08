-- =========================================================
-- File: 01_goto/A2_salary_review.sql
-- Purpose: Review each employee's salary and classify it
--          into a band (LOW / MEDIUM / HIGH) using GOTO.
-- Author : Kevin (Student ID: 27780)
-- =========================================================

SET SERVEROUTPUT ON;

DECLARE
   CURSOR c_emp IS
      SELECT emp_id, first_name, last_name, salary
      FROM employees
      ORDER BY emp_id;

   v_emp_id      employees.emp_id%TYPE;
   v_first_name  employees.first_name%TYPE;
   v_last_name   employees.last_name%TYPE;
   v_salary      employees.salary%TYPE;
BEGIN
   DBMS_OUTPUT.PUT_LINE('=========================================');
   DBMS_OUTPUT.PUT_LINE('      SALARY REVIEW REPORT');
   DBMS_OUTPUT.PUT_LINE('=========================================');

   OPEN c_emp;
   LOOP
      FETCH c_emp INTO v_emp_id, v_first_name, v_last_name, v_salary;
      EXIT WHEN c_emp%NOTFOUND;

      DBMS_OUTPUT.PUT_LINE('Employee: ' || v_emp_id || ' - ' ||
                           v_first_name || ' ' || v_last_name ||
                           ' | Salary: ' || v_salary);

      -- Classify salary using GOTO
      IF v_salary >= 7000 THEN
         GOTO band_high;
      ELSIF v_salary >= 4500 THEN
         GOTO band_medium;
      ELSE
         GOTO band_low;
      END IF;

      -- ------------------------------
      <<band_high>>
      DBMS_OUTPUT.PUT_LINE('   -> Band: HIGH (>= 7000)');
      GOTO next_employee;

      -- ------------------------------
      <<band_medium>>
      DBMS_OUTPUT.PUT_LINE('   -> Band: MEDIUM (4500 - 6999)');
      GOTO next_employee;

      -- ------------------------------
      <<band_low>>
      DBMS_OUTPUT.PUT_LINE('   -> Band: LOW (< 4500)');

      -- ------------------------------
      <<next_employee>>
      DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
   END LOOP;
   CLOSE c_emp;

   DBMS_OUTPUT.PUT_LINE('Salary review complete.');
END;
/
