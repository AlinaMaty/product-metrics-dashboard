-- DAU: количество уникальных пользователей по дням
SELECT order_date, COUNT(DISTINCT user_id) AS dau
FROM orders
GROUP BY order_date
ORDER BY order_date;

-- Top categories by revenue
SELECT category, SUM(quantity * price) AS revenue
FROM order_items
GROUP BY category
ORDER BY revenue DESC;

-- Retention: пользователи через 1 день после регистрации
WITH cohorts AS (
    SELECT user_id, signup_date
    FROM users
)
SELECT c.signup_date, o.order_date, COUNT(DISTINCT o.user_id) AS retained_users
FROM cohorts c
JOIN orders o ON c.user_id = o.user_id AND o.order_date = DATE_ADD(c.signup_date, INTERVAL 1 DAY)
GROUP BY c.signup_date, o.order_date
ORDER BY c.signup_date;
