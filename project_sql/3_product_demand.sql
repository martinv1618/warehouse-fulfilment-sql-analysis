/*
Question: Which products are most in demand?

- Count how many orders each product appears in.
- Display the top 5 products.
- Sort by demand from highest to lowest.
*/

SELECT
    p.product_id,
    p.product_name,
    p.category,
    COUNT(oi.order_id) AS demand_count
FROM order_items_bridge AS oi
INNER JOIN products_dim AS p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY demand_count DESC
LIMIT 5;