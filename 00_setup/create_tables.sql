-- =========================================================
-- File: 00_setup/create_tables.sql
-- Purpose: Create base tables for the PL/SQL assignment
-- Author : Kevin (Student ID: 27780)
-- DB     : Oracle Database 21c Express Edition
-- =========================================================

SET SERVEROUTPUT ON;

-- ---------------------------------------------------------
-- Drop tables if they already exist (clean re-run)
-- ---------------------------------------------------------
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE employees CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN RAISE; END IF;  -- -942 = table does not exist
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE departments CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

-- ---------------------------------------------------------
-- Table: departments
-- ---------------------------------------------------------
CREATE TABLE departments (
   dept_id     NUMBER(4)      PRIMARY KEY,
   dept_name   VARCHAR2(50)   NOT NULL
);

-- ---------------------------------------------------------
-- Table: employees
-- ---------------------------------------------------------
CREATE TABLE employees (
   emp_id       NUMBER(6)     PRIMARY KEY,
   first_name   VARCHAR2(30)  NOT NULL,
   last_name    VARCHAR2(30)  NOT NULL,
   email        VARCHAR2(50)  UNIQUE,
   hire_date    DATE          NOT NULL,
   job_id       VARCHAR2(20),
   salary       NUMBER(10,2)  NOT NULL,
   commission   NUMBER(10,2)  DEFAULT 0,
   dept_id      NUMBER(4)     REFERENCES departments(dept_id)
);

-- ---------------------------------------------------------
-- Seed data: departments
-- ---------------------------------------------------------
INSERT INTO departments VALUES (10, 'IT');
INSERT INTO departments VALUES (20, 'Finance');
INSERT INTO departments VALUES (30, 'Human Resources');
INSERT INTO departments VALUES (40, 'Marketing');
INSERT INTO departments VALUES (50, 'Operations');

-- ---------------------------------------------------------
-- Seed data: employees
-- ---------------------------------------------------------
INSERT INTO employees VALUES (1001, 'Alice',  'Mugisha', 'alice@corp.com',  TO_DATE('2018-03-15','YYYY-MM-DD'), 'IT_PROG',   4500, 200, 10);
INSERT INTO employees VALUES (1002, 'Brian',  'Habimana','brian@corp.com',  TO_DATE('2020-07-01','YYYY-MM-DD'), 'FIN_ANLST', 5200, 300, 20);
INSERT INTO employees VALUES (1003, 'Carla',  'Uwase',   'carla@corp.com',  TO_DATE('2015-01-20','YYYY-MM-DD'), 'HR_MGR',    6800,   0, 30);
INSERT INTO employees VALUES (1004, 'David',  'Nkusi',   'david@corp.com',  TO_DATE('2022-09-10','YYYY-MM-DD'), 'MKT_EXEC',  3800, 150, 40);
INSERT INTO employees VALUES (1005, 'Eva',    'Mutoni',  'eva@corp.com',    TO_DATE('2019-11-05','YYYY-MM-DD'), 'OPS_SPEC',  4100, 100, 50);
INSERT INTO employees VALUES (1006, 'Frank',  'Rwigema', 'frank@corp.com',  TO_DATE('2017-06-12','YYYY-MM-DD'), 'IT_MGR',    7200, 500, 10);
INSERT INTO employees VALUES (1007, 'Grace',  'Iradukunda','grace@corp.com',TO_DATE('2021-02-25','YYYY-MM-DD'), 'FIN_MGR',   7500,   0, 20);
INSERT INTO employees VALUES (1008, 'Henry',  'Kamanzi', 'henry@corp.com',  TO_DATE('2016-08-30','YYYY-MM-DD'), 'HR_SPEC',   3900, 120, 30);

COMMIT;

-- ---------------------------------------------------------
-- Verify
-- ---------------------------------------------------------
PROMPT ================================
PROMPT Departments loaded:
SELECT * FROM departments;
PROMPT ================================
PROMPT Employees loaded:
SELECT emp_id, first_name, last_name, salary, dept_id FROM employees;
PROMPT ================================
PROMPT Setup complete.
