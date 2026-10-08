# Reflection — Individual Assignment III

**Student:** Kevin  
**Student ID:** 27780  
**Course:** Database Development with PL/SQL  

---

## 1. Overview

This assignment covered two main areas of PL/SQL: **GOTO statements** and **stored functions**. I built a small payroll system on Oracle Database 21c XE using SQL Developer, and implemented four GOTO programs, four standalone functions, a combined payroll validator, and a full test suite.

---

## 2. What I Learned About GOTO

### The Basics
`GOTO label;` transfers control flow to a labeled section (`<<label>>`) within the same PL/SQL block. It can simplify certain state-machine-style logic, but it makes code harder to follow and debug when overused.

### The Rules
- A GOTO **must** target a label in the **same scope** (same block or an enclosing block).
- It **cannot** jump **into** a nested block, an `IF`, a `LOOP`, or an `EXCEPTION` handler.
- It **cannot** jump **out of** a subprogram into its caller.

### The Illegal Case I Hit
In **A3**, I tried to jump from the outer block into a label defined inside a nested block:

```plsql
GOTO inside_block;   -- illegal
DECLARE
   ...
BEGIN
   <<inside_block>>
   ...
END;
```

Oracle rejected this at compile time with:

```
ORA-06550: line 5, column 9:
PLS-00201: identifier 'INSIDE_BLOCK' must be declared
```

This clearly demonstrated why GOTO must respect block boundaries — the label simply isn't visible outside its block.

### The Lesson
In **A4**, I rewrote A2's salary review without a single GOTO using plain `IF/ELSIF/ELSE`. The result was shorter, clearer, and easier to test. **Conclusion: if you can write it without GOTO, you should.**

---

## 3. What I Learned About Stored Functions

Unlike anonymous PL/SQL blocks, stored functions:
- Persist in the database schema,
- Can be called from **SQL** (not just PL/SQL),
- Must **return exactly one value**,
- Support parameters via `IN`, `OUT`, and `IN OUT` modes.

I built four base functions:

| Function | Purpose |
|----------|---------|
| `fn_annual_salary` | Monthly × 12 |
| `fn_years_of_service` | `FLOOR(MONTHS_BETWEEN(SYSDATE, hire_date)/12)` |
| `fn_calculate_tax` | Tiered tax (0%, 10%, 20%, 30%) |
| `fn_dept_name` | Look up department name, return `'UNKNOWN'` if not found |

And one combined validator: `fn_validate_payroll`, which calls all four base functions and returns a formatted status string.

### Using Functions in SQL
The most satisfying moment was **B5**, where I used every function inside a single `SELECT`:

```sql
SELECT emp_id,
       fn_annual_salary(salary)          AS annual_salary,
       fn_years_of_service(hire_date)    AS years_of_service,
       fn_calculate_tax(salary)          AS monthly_tax,
       fn_dept_name(dept_id)             AS department
FROM   employees;
```

This is where PL/SQL functions really shine — they extend SQL itself.

---

## 4. Exception Handling

I used exception handling in two ways:

1. **Internal handlers** — e.g., `WHEN NO_DATA_FOUND THEN RETURN 'UNKNOWN'` in `fn_dept_name`.
2. **`RAISE_APPLICATION_ERROR`** — to signal invalid input (negative salary, future hire date).

The combined validator nests a `BEGIN ... EXCEPTION ... END` sub-block so it can gracefully return `INVALID` for a missing employee without killing the entire outer block.

---

## 5. Testing

The test files (`test_functions.sql` and `test_validate_payroll.sql`) use lightweight assertions — comparing return values to expected results and printing `PASS:` or `FAIL:`. All tests pass. This convinced me that even simple test scripts catch edge cases (NULL input, negative values, unknown IDs) that ad-hoc queries miss.

---

## 6. Challenges and Solutions

| Challenge | Solution |
|-----------|----------|
| SQL Developer 26 doesn't create worksheets the same way as older versions | Reused an existing worksheet tab and cleared it |
| Nested folder structure on GitHub on the first attempt | Deleted and recreated with each file starting from the repo root |
| `GOTO` accepted in some Oracle 21c cases where I expected it to fail | Used a different illegal case (jumping into a nested block) that reliably fails |
| Long validation strings wrapping in SQL Developer | Used `SET LINESIZE 200` / `250` before the SELECT |

---

## 7. AI Assistance

I used an AI assistant to help with:
- Suggesting the reliable illegal-GOTO case after the first attempt unexpectedly compiled,
- Reviewing the code for edge cases.

**All final code was typed, run, debugged, and verified by me in Oracle SQL Developer.** I can explain every line in the submission.

---


**End of reflection.**
