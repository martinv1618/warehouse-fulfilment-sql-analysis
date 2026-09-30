/*
Question: Which warehouses process the highest-value orders?

- Identify the top 10 highest-value orders.
- Exclude orders where unit_cost is NULL.
- Include warehouse information.
- Sort from highest order value to lowest.

Why?
This helps identify where high-value order activity is occurring
and provides insight into warehouse performance.
*/

SELECT
    o.order_id,
    w.warehouse_name,
    w.city,
    o.order_date,
    o.units,
    o.unit_cost,
    o.units * o.unit_cost AS order_value,
    o.status
FROM orders_fact AS o
LEFT JOIN warehouses_dim AS w
    ON o.warehouse_id = w.warehouse_id
WHERE o.unit_cost IS NOT NULL
ORDER BY order_value DESC
LIMIT 10;