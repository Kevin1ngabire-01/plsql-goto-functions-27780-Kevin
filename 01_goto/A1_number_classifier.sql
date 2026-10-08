-- =========================================================
-- File: 01_goto/A1_number_classifier.sql
-- Purpose: Classify a number as positive, negative, or zero
--          using PL/SQL GOTO statements
-- Author : Kevin (Student ID: 27780)
-- =========================================================

SET SERVEROUTPUT ON;

DECLARE
   v_number   NUMBER := -42;   -- Try changing this: 15, 0, -7, 100
BEGIN
   DBMS_OUTPUT.PUT_LINE('Classifying number: ' || v_number);

   -- Jump to appropriate classifier based on the value
   IF v_number > 0 THEN
      GOTO label_positive;
   ELSIF v_number < 0 THEN
      GOTO label_negative;
   ELSE
      GOTO label_zero;
   END IF;

   -- -----------------------------
   <<label_positive>>
   DBMS_OUTPUT.PUT_LINE('Result: The number is POSITIVE');
   GOTO end_block;

   -- -----------------------------
   <<label_negative>>
   DBMS_OUTPUT.PUT_LINE('Result: The number is NEGATIVE');
   GOTO end_block;

   -- -----------------------------
   <<label_zero>>
   DBMS_OUTPUT.PUT_LINE('Result: The number is ZERO');

   -- -----------------------------
   <<end_block>>
   DBMS_OUTPUT.PUT_LINE('Classification complete.');
END;
/
