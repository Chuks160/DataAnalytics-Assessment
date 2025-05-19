-- Assessment_Q1.sql
-- High-Value Customers with Multiple Products
SELECT 
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    COALESCE(s.savings_count, 0) AS savings_count,
    COALESCE(i.investment_count, 0) AS investment_count,
    ROUND(SUM(sa.confirmed_amount) / 100, 2) AS total_deposits
FROM users_customuser u
LEFT JOIN (
    SELECT owner_id, COUNT(*) AS savings_count
    FROM plans_plan
    WHERE is_regular_savings = 1
    GROUP BY owner_id
) s ON u.id = s.owner_id
LEFT JOIN (
    SELECT owner_id, COUNT(*) AS investment_count
    FROM plans_plan
    WHERE is_a_fund = 1
    GROUP BY owner_id
) i ON u.id = i.owner_id
JOIN savings_savingsaccount sa ON sa.owner_id = u.id
WHERE s.savings_count IS NOT NULL AND i.investment_count IS NOT NULL
GROUP BY u.id, name, s.savings_count, i.investment_count
ORDER BY total_deposits DESC;
