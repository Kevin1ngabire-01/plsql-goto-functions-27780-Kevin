-- =========================================================
-- File: 03_tests/test_functions.sql
-- Purpose: Systematic tests for all custom functions
-- Author : Kevin (Student ID: 27780)
-- =========================================================

SET SERVEROUTPUT ON;
SET LINESIZE 200;

PROMPT ================================================================
PROMPT  TEST SUITE: fn_annual_salary
PROMPT ================================================================
DECLARE
   v_result NUMBER;
BEGIN
   -- Test 1: Normal salary
   v_result := fn_annual_salary(4500);
   IF v_result = 54000 THEN
      DBMS_OUTPUT.PUT_LINE('PASS: fn_annual_salary(4500) = 54000');
   ELSE
      DBMS_OUTPUT.PUT_LINE('FAIL: expected 54000, got ' || v_result);
   END IF;

   -- Test 2: Zero salary
   v_result := fn_annual_salary(0);
   IF v_result = 0 THEN
      DBMS_OUTPUT.PUT_LINE('PASS: fn_annual_salary(0) = 0');
   ELSE
      DBMS_OUTPUT.PUT_LINE('FAIL: expected 0, got ' || v_result);
   END IF;

   -- Test 3: Negative salary (should return NULL after error)
   v_result := fn_annual_salary(-100);
   IF v_result IS NULL THEN
      DBMS_OUTPUT.PUT_LINE('PASS: fn_annual_salary(-100) returned NULL');
   ELSE
      DBMS_OUTPUT.PUT_LINE('FAIL: expected NULL, got ' || v_result);
   END IF;
END;
/

PROMPT
PROMPT ================================================================
PROMPT  TEST SUITE: fn_years_of_service
PROMPT ================================================================
DECLARE
   v_result NUMBER;
BEGIN
   v_result := fn_years_of_service(TO_DATE('2018-03-15','YYYY-MM-DD'));
   IF v_result >= 8 THEN
      DBMS_OUTPUT.PUT_LINE('PASS: fn_years_of_service(2018-03-15) = ' || v_result);
   ELSE
      DBMS_OUTPUT.PUT_LINE('FAIL: expected >=8, got ' || v_result);
   END IF;

   v_result := fn_years_of_service(SYSDATE);
   IF v_result = 0 THEN
      DBMS_OUTPUT.PUT_LINE('PASS: fn_years_of_service(today) = 0');
   ELSE
      DBMS_OUTPUT.PUT_LINE('FAIL: expected 0, got ' || v_result);
   END IF;

   -- Future date should return NULL
   v_result := fn_years_of_service(SYSDATE + 30);
   IF v_result IS NULL THEN
      DBMS_OUTPUT.PUT_LINE('PASS: future date returned NULL');
   ELSE
      DBMS_OUTPUT.PUT_LINE('FAIL: expected NULL, got ' || v_result);
   END IF;
END;
/

PROMPT
PROMPT ================================================================
PROMPT  TEST SUITE: fn_calculate_tax
PROMPT ================================================================
DECLARE
   v_result NUMBER;
BEGIN
   v_result := fn_calculate_tax(2500);
   IF v_result = 0 THEN
      DBMS_OUTPUT.PUT_LINE('PASS: tax(2500) = 0');
   ELSE
      DBMS_OUTPUT.PUT_LINE('FAIL: expected 0, got ' || v_result);
   END IF;

   v_result := fn_calculate_tax(4500);
   IF v_result = 450 THEN
      DBMS_OUTPUT.PUT_LINE('PASS: tax(4500) = 450');
   ELSE
      DBMS_OUTPUT.PUT_LINE('FAIL: expected 450, got ' || v_result);
   END IF;

   v_result := fn_calculate_tax(6000);
   IF v_result = 1200 THEN
      DBMS_OUTPUT.PUT_LINE('PASS: tax(6000) = 1200');
   ELSE
      DBMS_OUTPUT.PUT_LINE('FAIL: expected 1200, got ' || v_result);
   END IF;

   v_result := fn_calculate_tax(9000);
   IF v_result = 2700 THEN
      DBMS_OUTPUT.PUT_LINE('PASS: tax(9000) = 2700');
   ELSE
      DBMS_OUTPUT.PUT_LINE('FAIL: expected 2700, got ' || v_result);
   END IF;
END;
/

PROMPT
PROMPT ================================================================
PROMPT  TEST SUITE: fn_dept_name
PROMPT ================================================================
DECLARE
   v_result VARCHAR2(50);
BEGIN
   v_result := fn_dept_name(10);
   IF v_result = 'IT' THEN
      DBMS_OUTPUT.PUT_LINE('PASS: fn_dept_name(10) = IT');
   ELSE
      DBMS_OUTPUT.PUT_LINE('FAIL: expected IT, got ' || v_result);
   END IF;

   v_result := fn_dept_name(30);
   IF v_result = 'Human Resources' THEN
      DBMS_OUTPUT.PUT_LINE('PASS: fn_dept_name(30) = Human Resources');
   ELSE
      DBMS_OUTPUT.PUT_LINE('FAIL: expected Human Resources, got ' || v_result);
   END IF;

   v_result := fn_dept_name(99);
   IF v_result = 'UNKNOWN' THEN
      DBMS_OUTPUT.PUT_LINE('PASS: fn_dept_name(99) = UNKNOWN');
   ELSE
      DBMS_OUTPUT.PUT_LINE('FAIL: expected UNKNOWN, got ' || v_result);
   END IF;

   v_result := fn_dept_name(NULL);
   IF v_result = 'UNKNOWN' THEN
      DBMS_OUTPUT.PUT_LINE('PASS: fn_dept_name(NULL) = UNKNOWN');
   ELSE
      DBMS_OUTPUT.PUT_LINE('FAIL: expected UNKNOWN, got ' || v_result);
   END IF;
END;
/

PROMPT
PROMPT ================================================================
PROMPT  ALL FUNCTION TESTS COMPLETE
PROMPT ================================================================
