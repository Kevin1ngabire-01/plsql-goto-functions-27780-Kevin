-- =========================================================
-- File: 01_goto/A3_illegal_goto.sql
-- Purpose: Demonstrate an ILLEGAL GOTO (commented out) and
--          show the FIXED version that compiles.
-- Author : Kevin (Student ID: 27780)
--
-- Rule demonstrated:
--   GOTO cannot jump INTO a nested block from outside.
--   The target label must be in the SAME scope as the GOTO.
-- =========================================================

SET SERVEROUTPUT ON;

-- =========================================================
-- ❌ ILLEGAL VERSION (kept here for documentation)
-- This does NOT compile. Oracle returns:
--
--   ERROR at line 5:
--   ORA-06550: line 5, column 9:
--   PLS-00201: identifier 'INSIDE_BLOCK' must be declared
--   ORA-06550: line 5, column 4:
--   PL/SQL: Statement ignored
-- =========================================================
/*
DECLARE
   v_x NUMBER := 0;
BEGIN
   GOTO inside_block;   -- ❌ ILLEGAL: label is in a nested block

   DECLARE
      v_y NUMBER := 5;
   BEGIN
      <<inside_block>>
      DBMS_OUTPUT.PUT_LINE('Inside inner block: v_y = ' || v_y);
   END;
END;
/
*/

-- =========================================================
-- ✅ FIXED VERSION — GOTO targets a label in the SAME scope
-- =========================================================
DECLARE
   v_x NUMBER := 0;
BEGIN
   DBMS_OUTPUT.PUT_LINE('Starting with v_x = ' || v_x);

   IF v_x = 0 THEN
      GOTO zero_case;    -- ✅ LEGAL: label is in the same block
   END IF;

   DBMS_OUTPUT.PUT_LINE('This line is skipped');

   <<zero_case>>
   DBMS_OUTPUT.PUT_LINE('Reached zero_case label. GOTO was legal.');

   -- Enter the nested block normally (NOT via GOTO)
   DECLARE
      v_y NUMBER := 5;
   BEGIN
      DBMS_OUTPUT.PUT_LINE('Inside inner block: v_y = ' || v_y);
   END;

   DBMS_OUTPUT.PUT_LINE('Fixed version ran successfully.');
END;
/
