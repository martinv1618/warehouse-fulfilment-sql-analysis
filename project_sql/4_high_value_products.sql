/*
Question: Which products are associated with the highest average order value?

- Calculate the average value of orders containing each product.
- Exclude orders where unit_cost is NULL.
- Return the top 25 products.
*/

SELECT
    p.product_id,
    p.product_name,
    p.category,
    ROUND(
        AVG(o.units * o.unit_cost),
        2
    ) AS avg_order_value
FROM orders_fact AS o
INNER JOIN order_items_bridge AS oi
    ON o.order_id = oi.order_id
INNER JOIN products_dim AS p
    ON oi.product_id = p.product_id
WHERE o.unit_cost IS NOT NULL
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY avg_order_value DESC
LIMIT 25;