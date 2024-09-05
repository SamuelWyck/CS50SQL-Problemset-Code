CREATE TABLE ingredients (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "unit_of_purchase" TEXT NOT NULL,
    "price_per_unit($)" REAL NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE donuts (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    "gluten_free" INTEGER NOT NULL DEFAULT 0 CHECK("gluten_free" IN (0, 1)),
    "price($)" REAL NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE donut_ingredients (
    "id" INTEGER,
    "ingredient_id" INTEGER,
    "donut_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("ingredient_id") REFERENCES "ingredients"("id"),
    FOREIGN KEY ("donut_id") REFERENCES "donuts"("id")
);

CREATE TABLE customers (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE orders (
    "id" INTEGER,
    "order_number" INTEGER NOT NULL UNIQUE,
    "customer_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("customer_id") REFERENCES "customers"("id")
);

CREATE TABLE order_contents (
    "order_id" INTEGER,
    "number_of_donuts" INTEGER NOT NULL DEFAULT 1 CHECK("number_of_donuts" > 0),
    "donut_id" INTEGER,
    FOREIGN KEY("order_id") REFERENCES "orders"("id"),
    FOREIGN KEY("donut_id") REFERENCES "donuts"("id")
);

--SELECT name FROM donuts WHERE id IN (
    --SELECT donut_id FROM order_contents WHERE order_id = (
        --SELECT id FROM orders WHERE customer_id = (
            --SELECT id FROM customer WHERE first_name = 'Bob' AND last_name = 'Smith')));
