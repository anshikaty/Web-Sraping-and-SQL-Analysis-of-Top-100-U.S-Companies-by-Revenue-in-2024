CREATE DATABASE companies_revenue

select * from revenue_data;
describe revenue_data

ALTER TABLE revenue_data
CHANGE COLUMN `Revenue (USD millions)` revenue_in_millions DECIMAL(15,2);
-- Revenue Analysis by Industries
select industry , sum(revenue_in_millions) as total_revenue 
from revenue_data
group by industry
order by  total_revenue desc;
-- Top 10 companies by revenue
select name, revenue_in_millions
from revenue_data
order by revenue_in_millions desc
limit 10;
-- Average revenue growth by industry
ALTER TABLE revenue_data
CHANGE COLUMN `Revenue Growth` revenue_growth DECIMAL(15,2);
select industry , avg_revenue as highest_avg_revenue from 
(select industry , avg(revenue_growth) as avg_revenue
from revenue_data
group by industry
order by avg_revenue desc) as a
limit 5;

-- Employee Distribution by industry 
SET SQL_SAFE_UPDATES=0;
update revenue_data
set Employees =replace(employees,',','');
alter table revenue_data
modify column Employees int;
select industry , sum(Employees) as total_employees
from revenue_data
group by industry
order by total_employees desc;
-- revenue per employee
select name, revenue_in_millions/employees as revenue_per_employees
from revenue_data
order by revenue_per_employees desc;

-- Headquarter Analysis
select headquarters , count(headquarters) as count
from revenue_data
group by Headquarters
order by count desc;

-- companies which have revenue growth rates  above 20%
select name, revenue_growth
from revenue_data
where revenue_growth >20.0
order by revenue_growth desc;
-- minimum revnue growth of companies
select name, revenue_growth
from revenue_data
where revenue_growth <0;

select count(*) as lower_revenue_companies_count
from revenue_data
where revenue_growth <0;






