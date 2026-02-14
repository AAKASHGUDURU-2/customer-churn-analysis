CREATE DATABASE churn_project;
USE churn_project;
SELECT * FROM telco_customers LIMIT 5;
SELECT COUNT(*) FROM telco_customers;
DESCRIBE telco_customers;

# 1. We r finding total_customers, churned_customers, churn_rate_percent
SELECT COUNT(*) AS total_customers, 
SUM(CASE WHEN Churn = "Yes" THEN 1 ELSE 0 END) AS churned_customers,
ROUND(100 * SUM(CASE WHEN Churn = "Yes" THEN 1 ELSE 0 END)/COUNT(*) , 2) AS churn_rate_percent
FROM telco_customers;
# Roughly 1 in 4 customers are leaving, which is a very high churn level for a subscription business and indicates a significant revenue retention problem.
# Always practice saying the business meaning, not just numbers.

# 2. How much monthly revenue are we losing due to churn?
# We should find monthly charges, monthly income of people who churned and minus of both to find the revenue loss
SELECT SUM(MonthlyCharges) AS total_monthly_revenue,
SUM(CASE WHEN Churn = "Yes" THEN MonthlyCharges ELSE 0 END) AS revenue_lost_due_to_churn,
SUM(MonthlyCharges) - SUM(CASE WHEN Churn = "Yes" THEN MonthlyCharges ELSE 0 END) AS retained_monthly_revenue
FROM telco_customers;
# Nearly 30% of monthly recurring revenue is at risk due to churn, which represents a significant financial leakage for the business.
# Always practice converting results into 1-line executive insight like this. Interviewers love it.

# Just remember to write the column names correctly. By the names we can say u understand the concept correctly.
# Also u might think why not we write two queries rather than one complex for above soln. Because while exporting to dashboard it will be easy for analysis

# 3. Which contract types drive the most churn? 
# Write a SQL query that shows: Contract, total customers, churned customers, churn rate %
SELECT Contract, COUNT(*),
SUM(CASE WHEN Churn = "Yes" THEN 1 ELSE 0 END) AS churned_customers,
100 * SUM(CASE WHEN Churn = "Yes" THEN 1 ELSE 0 END) / COUNT(*) AS churn_rate_percent
FROM telco_customers
GROUP BY Contract;

# 4. Revenue Lost Due to Churn by Contract
SELECT Contract, 
SUM(CASE WHEN Churn = "Yes" THEN MonthlyCharges END) AS revenue_lost_due_to_churn
FROM telco_customers
GROUP BY Contract
ORDER BY revenue_lost_due_to_churn DESC;


   
