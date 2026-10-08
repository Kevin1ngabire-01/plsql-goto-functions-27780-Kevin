-- =========================================================
-- File: 01_goto/A4_rewrite_no_goto.sql
-- Purpose: Rewrite A2's salary review WITHOUT using GOTO.
--          Same output, cleaner control flow.
-- Author : Kevin (Student ID: 27780)
-- =========================================================

SET SERVEROUTPUT ON;

DECLARE
   CURSOR c_emp IS
      SELECT emp_id, first_name, last_name, salary
      FROM employees
      ORDER BY emp_id;

   v_band VARCHAR2(30);
BEGIN
   DBMS_OUTPUT.PUT_LINE('=========================================');
   DBMS_OUTPUT.PUT_LINE('   SALARY REVIEW REPORT (NO GOTO)');
   DBMS_OUTPUT.PUT_LINE('=========================================');

   FOR r IN c_emp LOOP
      DBMS_OUTPUT.PUT_LINE('Employee: ' || r.emp_id || ' - ' ||
                           r.first_name || ' ' || r.last_name ||
                           ' | Salary: ' || r.salary);

      -- Classify with plain IF/ELSIF/ELSE — no GOTO needed
      IF r.salary >= 7000 THEN
         v_band := 'HIGH (>= 7000)';
      ELSIF r.salary >= 4500 THEN
         v_band := 'MEDIUM (4500 - 6999)';
      ELSE
         v_band := 'LOW (< 4500)';
      END IF;

      DBMS_OUTPUT.PUT_LINE('   -> Band: ' || v_band);
      DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
   END LOOP;

   DBMS_OUTPUT.PUT_LINE('Salary review complete (no GOTO used).');
END;
/
