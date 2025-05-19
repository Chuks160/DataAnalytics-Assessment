-- Assessment_Q2.sql
-- Transaction Frequency Analysis
WITH transaction_summary AS (
    SELECT 
        owner_id,
        COUNT(*) AS total_txn,
        PERIOD_DIFF(EXTRACT(YEAR_MONTH FROM MAX(created_at)), EXTRACT(YEAR_MONTH FROM MIN(created_at))) + 1 AS months_active
    FROM savings_savingsaccount
    GROUP BY owner_id
),
frequency_calc AS (
    SELECT *,
           ROUND(total_txn / months_active, 2) AS txn_per_month,
           CASE
               WHEN total_txn / months_active >= 10 THEN 'High Frequency'
               WHEN total_txn / months_active BETWEEN 3 AND 9 THEN 'Medium Frequency'
               ELSE 'Low Frequency'
           END AS frequency_category
    FROM transaction_summary
)
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(txn_per_month), 2) AS avg_transactions_per_month
FROM frequency_calc
GROUP BY frequency_category;
