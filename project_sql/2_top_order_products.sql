/*
Question: Which products appear in the top 10 highest-value orders?

- Reuse the top 10 highest-value orders.
- Connect orders to products through order_items_bridge.
- Show the products associated with those high-value orders.
*/

WITH top_orders AS (
    SELECT
        o.order_id,
        w.warehouse_name,
        o.units * o.unit_cost AS order_value
    FROM orders_fact AS o
    LEFT JOIN warehouses_dim AS w
        ON o.warehouse_id = w.warehouse_id
    WHERE o.unit_cost IS NOT NULL
    ORDER BY order_value DESC
    LIMIT 10
)

SELECT
    top_orders.order_id,
    top_orders.warehouse_name,
    top_orders.order_value,
    p.product_name,
    p.category,
    oi.quantity
FROM top_orders
INNER JOIN order_items_bridge AS oi
    ON top_orders.order_id = oi.order_id
INNER JOIN products_dim AS p
    ON oi.product_id = p.product_id
ORDER BY top_orders.order_value DESC;