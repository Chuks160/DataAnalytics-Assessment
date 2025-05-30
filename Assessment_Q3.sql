-- Assessment_Q3.sql
-- Account Inactivity Alert
SELECT 
    p.id AS plan_id,
    p.owner_id,
    CASE 
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type,
    MAX(sa.created_at) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(sa.created_at)) AS inactivity_days
FROM plans_plan p
LEFT JOIN savings_savingsaccount sa ON sa.plan_id = p.id
WHERE (p.is_regular_savings = 1 OR p.is_a_fund = 1)
GROUP BY p.id, p.owner_id, type
HAVING last_transaction_date IS NULL OR DATEDIFF(CURDATE(), last_transaction_date) > 365;
