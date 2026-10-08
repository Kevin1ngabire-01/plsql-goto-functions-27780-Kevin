-- =========================================================
-- File: 03_tests/test_validate_payroll.sql
-- Purpose: Test the combined payroll validator function
-- Author : Kevin (Student ID: 27780)
-- =========================================================

SET SERVEROUTPUT ON;
SET LINESIZE 250;

PROMPT ================================================================
PROMPT  TEST SUITE: fn_validate_payroll
PROMPT ================================================================
DECLARE
   v_status VARCHAR2(400);
BEGIN
   -- Test 1: Valid employee 1001 (Alice)
   v_status := fn_validate_payroll(1001);
   IF INSTR(v_status, 'Alice') > 0 AND INSTR(v_status, 'OK') > 0 THEN
      DBMS_OUTPUT.PUT_LINE('PASS: Employee 1001 validated');
      DBMS_OUTPUT.PUT_LINE('      ' || v_status);
   ELSE
      DBMS_OUTPUT.PUT_LINE('FAIL: ' || v_status);
   END IF;
   DBMS_OUTPUT.PUT_LINE('');

   -- Test 2: Valid employee 1003 (Carla)
   v_status := fn_validate_payroll(1003);
   IF INSTR(v_status, 'Carla') > 0 AND INSTR(v_status, 'OK') > 0 THEN
      DBMS_OUTPUT.PUT_LINE('PASS: Employee 1003 validated');
      DBMS_OUTPUT.PUT_LINE('      ' || v_status);
   ELSE
      DBMS_OUTPUT.PUT_LINE('FAIL: ' || v_status);
   END IF;
   DBMS_OUTPUT.PUT_LINE('');

   -- Test 3: Valid employee 1007 (Grace)
   v_status := fn_validate_payroll(1007);
   IF INSTR(v_status, 'Grace') > 0 AND INSTR(v_status, 'OK') > 0 THEN
      DBMS_OUTPUT.PUT_LINE('PASS: Employee 1007 validated');
      DBMS_OUTPUT.PUT_LINE('      ' || v_status);
   ELSE
      DBMS_OUTPUT.PUT_LINE('FAIL: ' || v_status);
   END IF;
   DBMS_OUTPUT.PUT_LINE('');

   -- Test 4: Invalid employee ID
   v_status := fn_validate_payroll(9999);
   IF INSTR(v_status, 'INVALID') > 0 THEN
      DBMS_OUTPUT.PUT_LINE('PASS: Invalid ID correctly rejected');
      DBMS_OUTPUT.PUT_LINE('      ' || v_status);
   ELSE
      DBMS_OUTPUT.PUT_LINE('FAIL: ' || v_status);
   END IF;
   DBMS_OUTPUT.PUT_LINE('');

   -- Test 5: NULL employee ID
   v_status := fn_validate_payroll(NULL);
   IF INSTR(v_status, 'INVALID') > 0 THEN
      DBMS_OUTPUT.PUT_LINE('PASS: NULL ID correctly rejected');
      DBMS_OUTPUT.PUT_LINE('      ' || v_status);
   ELSE
      DBMS_OUTPUT.PUT_LINE('FAIL: ' || v_status);
   END IF;
   DBMS_OUTPUT.PUT_LINE('');
END;
/

PROMPT ================================================================
PROMPT  Validate payroll for ALL employees
PROMPT ================================================================
SELECT emp_id,
       fn_validate_payroll(emp_id) AS validation_result
FROM employees
ORDER BY emp_id;

PROMPT
PROMPT ================================================================
PROMPT  VALIDATOR TESTS COMPLETE
PROMPT ================================================================
