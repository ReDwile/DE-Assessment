-- Calculate total sales amount and total number of transactions for each month
SELECT
    DATE_TRUNC('month', purchase_date) AS month,
    SUM(p.quantity * p.price) AS total_sales_amount,
    COUNT(st.transaction_id) AS total_number_of_transactions
FROM
    sales_transactions st
JOIN
    products p ON st.product_id = p.product_id
GROUP BY
    DATE_TRUNC('month', purchase_date)
ORDER BY
    month DESC;