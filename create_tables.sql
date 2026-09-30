CREATE TABLE warehouses_dim (
    warehouse_id INTEGER PRIMARY KEY,
    warehouse_name VARCHAR(100),
    city VARCHAR(100),
    region VARCHAR(100)
);

CREATE TABLE products_dim (
    product_id INTEGER PRIMARY KEY,
    product_name VARCHAR(150),
    category VARCHAR(100),
    unit_weight NUMERIC(8, 2)
);

CREATE TABLE orders_fact (
    order_id INTEGER PRIMARY KEY,
    warehouse_id INTEGER,
    order_date DATE,
    units INTEGER,
    status VARCHAR(50),
    delivery_note TEXT,
    unit_cost NUMERIC(10, 2),
    processing_minutes INTEGER,
    FOREIGN KEY (warehouse_id)
        REFERENCES warehouses_dim(warehouse_id)
);

CREATE TABLE order_items_bridge (
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    FOREIGN KEY (order_id)
        REFERENCES orders_fact(order_id),
    FOREIGN KEY (product_id)
        REFERENCES products_dim(product_id)
);