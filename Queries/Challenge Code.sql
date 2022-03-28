SELECT employees.first_name, employees.last_name, employees.emp_no, Titles.title, Titles.from_date, Titles.to_date
INTO Retirement_Titles
FROM employees
INNER JOIN Titles
ON employees.emp_no = Titles.emp_no
WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

SELECT * FROM Retirement_Titles

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (Retirement_Titles.emp_no) Retirement_Titles.emp_no, 
Retirement_Titles.first_name,
Retirement_Titles.last_name,
Retirement_Titles.title

INTO unique_titles
FROM Retirement_Titles
WHERE (Retirement_Titles.to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

-- Employees About to Retire
SELECT COUNT(unique_titles.title), unique_titles.title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

-- Mentorship Eligibility
SELECT DISTINCT ON (employees.emp_no) employees.emp_no, 
employees.first_name, 
employees.last_name, 
employees.birth_date, 
dept_emp.from_date, 
dept_emp.to_date, 
Titles.title

INTO mentorship_eligibilty
FROM employees
    INNER JOIN dept_emp
        ON employees.emp_no = dept_emp.emp_no
            INNER JOIN Titles
                ON employees.emp_no = Titles.emp_no
WHERE (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (dept_emp.to_date = '9999-01-01')
ORDER BY emp_no;
