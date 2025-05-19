# DataAnalytics-Assessment
Cowrywise-Data Analyst Assessment

Overview
This repository contains solutions to the SQL proficiency assessment for a Data Analyst role. The questions test various SQL skills including joins, subqueries, aggregation, filtering, grouping, and time-based calculations. The assessment is based on data from a digital banking platform with four key tables:

users_customuser: customer information
savings_savingsaccount: deposit transactions
plans_plan: savings and investment plans
withdrawals_withdrawal: withdrawal records

Q1: High-Value Customers with Multiple Products
Objective:Identify customers with at least one funded savings and one funded investment plan. Output includes count of plans and total deposits.

Approach:
Filter plans_plan into two subsets: regular savings (is_regular_savings = 1) and investments (is_a_fund = 1).
Count plans per customer.
Join with savings_savingsaccount to sum deposits.
Group and filter customers with both product types.

Challenge: Ensuring customers meet both conditions while still including deposit values.

Q2: Transaction Frequency Analysis
Objective:Categorize customers based on how frequently they transact per month.

Approach:
Use MIN and MAX of created_at in savings_savingsaccount to determine active months.
Count total transactions.
Divide to get monthly rate.
Use CASE to assign frequency category.

Challenge:Handling cases where the tenure is zero (single-month users).

Q3: Account Inactivity Alert
Objective:Find accounts with no inflow activity for over a year.

Approach:
Join plans_plan and savings_savingsaccount.
Aggregate to get last transaction date.
Use DATEDIFF from current date to calculate inactivity.
Filter for accounts where last transaction is more than 365 days old or null.

Challenge:Some accounts may not have any transactions, handled using LEFT JOIN.

Q4: Customer Lifetime Value (CLV) Estimation
Objective:Estimate CLV using tenure, number of transactions, and transaction value.

Approach:
Join users_customuser with savings_savingsaccount.
Calculate tenure in months.
Sum transaction value (convert from kobo).
Apply formula: (Total Value * 0.001 / tenure) * 12.
Order by estimated CLV.

Challenge:Avoid division by zero and ensure accurate conversions.

Notes
All monetary values are stored in kobo and converted to Naira.
Used Common Table Expressions (CTEs) to improve readability and step-by-step logic.
Assumed availability of timestamp fields such as `created_at` and `date_joined`.
