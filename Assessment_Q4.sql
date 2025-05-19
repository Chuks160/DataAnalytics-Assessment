-- Assessment_Q4.sql
-- Customer Lifetime Value (CLV) Estimation
WITH transaction_stats AS (
    SELECT 
        u.id AS customer_id,
        CONCAT(u.first_name, ' ', u.last_name) AS name,
        TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
        COUNT(sa.id) AS total_transactions,
        ROUND(SUM(sa.confirmed_amount) / 100, 2) AS total_transaction_value
    FROM users_customuser u
    LEFT JOIN savings_savingsaccount sa ON sa.owner_id = u.id
    GROUP BY u.id, name, tenure_months
),
clv_calc AS (
    SELECT *,
        ROUND(((total_transaction_value * 0.001) / tenure_months) * 12, 2) AS estimated_clv
    FROM transaction_stats
    WHERE tenure_months > 0
)
SELECT * 
FROM clv_calc
ORDER BY estimated_clv DESC;