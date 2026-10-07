DROP TABLE BANK_LOAN;

create table bank_loan (
ids SERIAL  PRIMARY KEY, 
address_state	VARCHAR  (30),
application_type	VARCHAR(30),
emp_length	VARCHAR(100) ,
emp_title	VARCHAR(100),
grade	VARCHAR(50),
home_ownership	VARCHAR(50),
issue_date	DATE,
last_credit_pull_date	DATE,
last_payment_date	DATE,
loan_status	VARCHAR(50),
next_payment_date	DATE,
member_id	INT ,
purpose	VARCHAR(50),
sub_grade	VARCHAR(50),
term	VARCHAR(50),
verification_status	VARCHAR(50),
annual_income	NUMERIC(10,2) ,
dti	NUMERIC(5,2),
installment	NUMERIC(10,2),
int_rate	NUMERIC(10,2),
loan_amount	NUMERIC(10,2),
total_acc	NUMERIC(5,2),
total_payment	INT);


SELECT * FROM BANK_LOAN;


--TOTAL LOAN APPLICATION 
SELECT count(application_type) as Total_application from bank_loan;


-- latest month application *
 select count(application_type) as  latest_month_application from bank_loan
 where extract(month from issue_date)=12 and  extract(year from issue_date)=2021;

--previous month to date loan apllication 
 select count (application_type) as previous_month_application from bank_loan 
 where extract(month from issue_date)=11 and extract(year from issue_date)=2021;;

--total fund amount MONTH TO DATE 
select sum (loan_amount) as MTDTotal_funded_amount from bank_loan
where extract (month from issue_date)=12 and extract (year from issue_date)=2021;

--TOTAL FUNDED AMOUNT  PREVIOUS MONTH TO DATE 
SELECT SUM (LOAN_AMOUNT)AS PMTDtotal_funded_amount  from bank_loan 
where extract (month from issue_date )=11 and extract (year from issue_date )=2021 ;

--TOTAL AMOUNT RECIVE 
SELECT SUM(TOTAL_PAYMENT) AS current_month_Total_amount_recieve FROM BANK_LOAN
where extract ( month from issue_date)=12 and extract( year from Issue_date )=2021;

--previous month total amount recieve 
SELECT SUM(TOTAL_PAYMENT) AS previous_month_Total_amount_recieve FROM BANK_LOAN
where extract ( month from issue_date)=11 and extract( year from Issue_date )=2021;

--month average interest rate 

select round( avg (int_rate),4)*100 AS month_todayavg_interest_rate
from  bank_loan
where extract (month from issue_date)=12 and extract (year from issue_date)=2021;

--previous month to date 
select round( avg (int_rate),4)*100 AS previous_month_today_avg_interest_rate
from  bank_loan
where extract (month from issue_date)=11 and extract (year from issue_date)=2021;

--average Debt to income ratio 
select round(avg(dti),4)*100 as average_dti 
from bank_loan 
where extract (month from issue_date)=12 and extract (year from issue_date )= 2021;

--avg debt to income ratio 
select round(avg(dti),4)*100 as average_dti 
from bank_loan 
where extract (month from issue_date)=11 and extract (year from issue_date )= 2021;



--good loan through the market 

SELECT 
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN ids END) * 100.0) / 
    COUNT(ids) AS good_loan_percentage 
FROM bank_loan;


---good loan apllicant 
select count (ids) from bank_loan_data 
where count (case when loan_status= 'fully paid 'or loan_status = 'current' then ids end ) from bank_loan ;




--good loan funded amount and good loan aplication and good loan recieve amount 

SELECT 
    COUNT(ids) AS good_loan_applications,
    SUM(loan_amount) AS good_loan_funded_amount,
    SUM(total_payment) AS good_loan_received_amount
FROM bank_loan
WHERE loan_status IN ('Fully Paid', 'Current');

--bad loan amount 
SELECT 
   round(COUNT(CASE WHEN loan_status = 'Charged Off' THEN ids END) * 100.0) / COUNT(ids) AS bad_loan_percentage
FROM bank_loan;



--- bad loan apllicant 
select count(ids) as bad_loan_apllicant from bank_loan
where loan_status = 'Charged Off';


--loan status grid view 


select LOAN_status,
count(ids) as loan_apllicant,
avg(int_rate*100) as total_interest,
sum(total_payment) as amount_recieve, 
avg (dti*100) as total_dti 
from bank_loan
group by loan_status;



---month to date loan grid 


select loan_status,
sum (total_payment) as amount_recieve ,
sum (loan_amount) as amount_invested 
 from bank_loan 
 where extract (month from issue_date) =12
 group by loan_status ;


--previous month to date loan grid 

select loan_status ,
sum (total_payment) as amount_recieve ,
sum (loan_amount) as amount_invested 
from bank_loan 
where extract (month from issue_date )=11
group by loan_status;
 
  
-- month to month comparision 


 select 
 extract (month from issue_date)as month_number ,
 to_char(issue_date,'month') as month_name  ,
 sum (total_payment)as amount_recieved,
  sum (loan_amount) as invested_amount from bank_loan
  group by month_number, month_name 
  order by  month_number asc ;


  -- regional_analysis_by state 
  



select address_state ,
count(ids)as apllicants,
sum (total_payment) as amount_recieved,
sum(loan_amount) as amount_invest
from bank_loan 
group by address_state order by apllicants desc;


--loan term analysis 


select  term  ,
count (ids) as apllicants,
sum (total_payment) as amount_invest,
sum (loan_amount) as amount_recieved
from bank_loan 
group by term 
order by apllicants;

-- employee leangth  
select  emp_length  ,
count (ids) as apllicants,
sum (total_payment) as amount_invest,
sum (loan_amount) as amount_recieved
from bank_loan 
group by emp_length
order by apllicants desc;

-- purpose 
select  purpose  ,
count (ids) as apllicants,
sum (total_payment) as amount_invest,
sum (loan_amount) as amount_recieved
from bank_loan 
group by purpose
order by apllicants desc;

----Home ownership 


SELECT * FROM BANK_LOAN;

select  HOME_OWNERSHIP  ,
count (ids) as apllicants,
sum (total_payment) as amount_invest,
sum (loan_amount) as amount_recieved
from bank_loan 
group by HOME_OWNERSHIP 
order by apllicants desc;













