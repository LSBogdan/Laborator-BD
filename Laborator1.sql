--2.3.
DESCRIBE employees;
DESCRIBE departments;
DESCRIBE jobs;
DESCRIBE job_history;
DESCRIBE locations;
DESCRIBE countries;
DESCRIBE regions;

--2.4.
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM jobs;
SELECT * FROM job_history;
SELECT * FROM locations;
SELECT * FROM countries;
SELECT * FROM regions;

--2.5 & 2.6.
SELECT employee_id as Cod, first_name as Nume, job_id as "Cod job", hire_date as "Data angajarii"
FROM employees;
--Selectia si proiectia sunt operatori relationali.
--Daca consideram atributele relatiei ca fiind niste dimensiuni, atunci:
--selectie --> se face atunci cand folosim WHERE(pastram doar liniile din relatie care verifica o anumita conditie);
--proiectie --> alegem doar o submultime de atribute(din cele n dimensiuni pastram doar cateva, deci facem proiectie pe anumite dimensiuni).
--Mai sus avem proiectie.

--2.7.
--Cu duplicate:
SELECT job_id 
FROM employees;

--Fara duplicate:
SELECT DISTINCT job_id
FROM employees;
--Optiunea DISTINCT se aplica pe tot tuplul, avem unicitate la nivel de tupluri!
SELECT DISTINCT departament_id, job_id
FROM employees;

--2.8.
SELECT first_name || ', ' || job_id as "Angajat si titlu"
FROM employees;

--2.9.
SELECT employee_id || ', ' || first_name || ', ' || last_name || ', ' || email || ', ' || phone_number || ', ' || ', ' || hire_date || ', ' || job_id || ', ' || salary || ', ' || commission_pct || ', ' || manager_id || ', ' || department_id as "Informatii complete"
FROM employees;

--2.10.
SELECT last_name || ', ' || job_id ||', ' || salary as "Angajat, titlu si salariu"
FROM employees
WHERE salary > 2850; -->selectie

--2.11.
SELECT last_name, department_id
FROM employees
WHERE employee_id = 104;

--2.12.
--Varianta 1:
SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 1500 AND 2850; -- [1500, 2850]
--Varianta 2:
SELECT last_name, salary
FROM employees
WHERE salary < 1500 OR salary > 2850;

--2.13.
SELECT last_name, job_id, hire_date
FROM employees
WHERE hire_date BETWEEN '20-FEB-1987' AND '1-MAY-1989'
ORDER BY hire_date;
--Format: 'ZI-LUNA-AN' pentru date calendaristice sau folosoim functii de conversie

SELECT SYSDATE 
FROM dual;
--Afisare data curenta

--2.14.
--Varianta 1:
SELECT last_name, employee_id
FROM employees
WHERE DEPARTMENT_ID = 10 OR DEPARTMENT_ID = 30 OR DEPARTMENT_ID = 50
ORDER BY last_name;
--Varianta 2:
SELECT last_name, employee_id
FROM employees
WHERE department_id IN (10, 30, 50)
ORDER BY last_name;

--2.15.
SELECT last_name as Angajat , salary as "Salariu lunar"
FROM employees
WHERE department_id IN (10, 30, 50) AND salary > 1500
ORDER BY last_name, first_name;
--Suplimentar: Afisati departamentele in care nu lucreaza angajati.
SELECT department_id, department_name
FROM departments
WHERE department_id NOT IN
    (SELECT DISTINCT department_id FROM employees WHERE department_id IS NOT NULL);
    
--NULL >  expr   NULL < expr     NULL + ...   se evalueaza NULL;
--NULL se interpreteaza ca NULL;
--NULL OR TRUE -->TRUE         NULL AND FALSE --> FALSE;
--IS NOT NULL este operatorul care testeaza daca ceva este diferit de NULL; 
--IS NULL este operatorul care testeaza daca ceva nu este diferit de NULL.

--2.16.
SELECT SYSDATE
FROM dual;

select to_char( sysdate , 'dd/mm/yyyy  hh24:mi AM' )
from dual;   

--2.17.
--Variana 1:
SELECT last_name, hire_date
FROM employees
WHERE hire_date LIKE ('%87%');
--Operatorul LIKE are doua caractere speciale: %(care inlocuieste orice sir de caractere, inclusiv sirul vid) si _(care inlocuieste un singur caracter).
--Varianta 2:
SELECT last_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY')='1987'; 
--Obs: NU sunt obligatorii ' ' la 1987.
--Varianta 3:
SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR from hire_date)='1987';

--2.18.
SELECT last_name, first_name
FROM employees
WHERE TO_CHAR(hire_date, 'DD')=(SELECT TO_CHAR(SYSDATE, 'DD') FROM dual);
--from dual nu e necesar

--2.19.
SELECT last_name, job_id
FROM employees 
WHERE manager_id IS NULL;

--2.20.
--Varianta 1:
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary, commission_pct DESC;
--Varianta 2:
SELECT last_name, salary sal, commission_pct com      
FROM employees                                        
WHERE commission_pct IS NOT NULL                     
ORDER BY sal DESC, com DESC;
--FROM->WHERE->SELECT->ORDER BY
--varianta 3:
SELECT last_name, salary sal, commission_pct com      
FROM employees                                        
WHERE commission_pct IS NOT NULL                  
ORDER BY 2 DESC, 3 DESC;   
--Ordonarea se face dupa a doua si a treia expresie din SELECT.

--2.21.
SELECT last_name, salary, commission_pct
FROM employees
ORDER BY salary, commission_pct DESC NULLS LAST; 
--Se putea pune si FIRST in loc de LAST.

--2.22.
--Varianta 1:
SELECT last_name, first_name
FROM employees
WHERE last_name LIKE ('__a%');
--Varianta 2:
SELECT last_name, first_nname
FROM employees
WHERE LOWER(last_name) LIKE ('__a%'); 

--2.23.
SELECT last_name
FROM employees
WHERE LOWER(last_name)LIKE ('%l%l%') AND (department_id = 30 OR manager_id = 102); 

--2.24.
SELECT last_name, job_id, salary
FROM employees
WHERE (job_id LIKE ('%CLERK%') OR job_id LIKE ('%REP%')) AND salary NOT IN (1000, 2000, 3000);

--2.25.
SELECT department_name
FROM departments
WHERE manager_id IS NULL;









