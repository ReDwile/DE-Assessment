-- Calculate the 3-month moving average of sales amount for each month
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', purchase_date) AS month,
        SUM(p.quantity * p.price) AS total_sales_amount
    FROM
        sales_transactions st
    JOIN
        products p ON st.product_id = p.product_id
    GROUP BY
        DATE_TRUNC('month', purchase_date)
)
SELECT
    month,
    total_sales_amount,
    AVG(total_sales_amount) OVER (
        ORDER BY month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_average_3_months
FROM
    monthly_sales
ORDER BY
    month DESC;

Explanation

•   Common Table Expression (CTE) monthly_sales:
•   Calculates the total sales amount for each month by truncating the purchase_date to the month level and summing up the sales amounts.
•   Main Query:
•   Uses a window function AVG(total_sales_amount) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) to calculate the 3-month moving average. This window frame includes the current month and the two preceding months.
•   The ORDER BY month clause ensures the results are ordered by month.