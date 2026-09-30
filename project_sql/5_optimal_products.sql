/*
Question: Which products combine strong demand with high average order value?

- Calculate product demand.
- Calculate average order value per product.
- Combine both result sets.
- Focus on products with meaningful demand.
- Rank high-value products with strong demand.
*/

WITH product_demand AS (
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
),

average_order_value AS (
    SELECT
        p.product_id,
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
    GROUP BY p.product_id
)

SELECT
    pd.product_id,
    pd.product_name,
    pd.category,
    pd.demand_count,
    aov.avg_order_value
FROM product_demand AS pd
INNER JOIN average_order_value AS aov
    ON pd.product_id = aov.product_id
WHERE pd.demand_count > 500
ORDER BY
    aov.avg_order_value DESC,
    pd.demand_count DESC
LIMIT 25;