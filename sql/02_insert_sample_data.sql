-- 02_insert_sample_data.sql
-- Insert sample data into employees table

INSERT INTO employees (emp_name, emp_role, emp_salary, emp_status) VALUES
('Alice', 'Developer', 1200, 'Active'),
('Bob', 'Tester', 900, 'Terminated'),
('Charlie', 'Manager', 2000, 'Active'),
('Diana', 'Developer', 1500, 'Active'),
('Eric', 'Tester', 800, 'Terminated');

COMMIT;

