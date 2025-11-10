-- 03_package_bonus.sql
-- Demonstrates PL/SQL Collections, Records, and GOTO statement

SET SERVEROUTPUT ON;

DECLARE
    -- Define a RECORD to hold employee details
    TYPE emp_record IS RECORD (
        name employees.emp_name%TYPE,
        role employees.emp_role%TYPE,
        salary employees.emp_salary%TYPE,
        status employees.emp_status%TYPE
    );

    -- Define a COLLECTION (nested table) of records
    TYPE emp_table IS TABLE OF emp_record;
    employees_list emp_table := emp_table();

    -- Variables
    v_total_bonus NUMBER := 0;
    v_bonus_rate  NUMBER := 0.1;  -- 10% bonus for active employees
BEGIN
    -- Load employees into the collection
    SELECT emp_name, emp_role, emp_salary, emp_status
    BULK COLLECT INTO employees_list
    FROM employees;

    -- Process each employee
    FOR i IN 1 .. employees_list.COUNT LOOP
        -- GOTO usage: skip terminated employees
        IF employees_list(i).status = 'Terminated' THEN
            GOTO skip_employee;
        END IF;

        -- Calculate bonus
        v_total_bonus := v_total_bonus + (employees_list(i).salary * v_bonus_rate);

        DBMS_OUTPUT.PUT_LINE('Employee: ' || employees_list(i).name ||
                             ' | Role: ' || employees_list(i).role ||
                             ' | Bonus: ' || TO_CHAR(employees_list(i).salary * v_bonus_rate, '9999.99'));
        CONTINUE;

        <<skip_employee>>
        NULL; -- Do nothing, just skip
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total Bonus for Active Employees: ' || v_total_bonus);
END;
/

