-- general por región script

-- regions
CREATE TABLE regions (
  region_id NUMBER GENERATED BY DEFAULT AS IDENTITY START WITH 5 PRIMARY KEY,
  region_name VARCHAR2(50) NOT NULL
);

-- countries table
CREATE TABLE countries (
  country_id CHAR(2) PRIMARY KEY,
  country_name VARCHAR2(40) NOT NULL,
  region_id NUMBER,
  -- fk
  CONSTRAINT fk_countries_regions FOREIGN KEY(region_id) REFERENCES regions(region_id) ON DELETE CASCADE
);

-- location
CREATE TABLE locations (
  location_id NUMBER GENERATED BY DEFAULT AS IDENTITY START WITH 24 PRIMARY KEY,
  address VARCHAR2(255) NOT NULL,
  postal_code VARCHAR2(20),
  city VARCHAR2(50),
  state VARCHAR2(50),
  country_id CHAR(2),
  -- fk
  CONSTRAINT fk_locations_countries FOREIGN KEY(country_id) REFERENCES countries(country_id) ON DELETE CASCADE
);

-- warehouses
CREATE TABLE warehouses (
  warehouse_id NUMBER GENERATED BY DEFAULT AS IDENTITY START WITH 10 PRIMARY KEY,
  warehouse_name VARCHAR(255),
  location_id NUMBER(12, 0),
  -- fk
  CONSTRAINT fk_warehouses_locations FOREIGN KEY(location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);

-- employees
CREATE TABLE employees (
  employee_id NUMBER GENERATED BY DEFAULT AS IDENTITY START WITH 108 PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(50) NOT NULL,
  hire_date DATE NOT NULL,
  manager_id NUMBER(12, 0),
  -- fk
  job_title VARCHAR(255) NOT NULL,
  CONSTRAINT fk_employees_manager FOREIGN KEY(manager_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);

-- product category
CREATE TABLE product_categories (
  category_id NUMBER GENERATED BY DEFAULT AS IDENTITY START WITH 6 PRIMARY KEY,
  category_name VARCHAR2(255) NOT NULL
);

-- products table
CREATE TABLE products (
  product_id NUMBER GENERATED BY DEFAULT AS IDENTITY START WITH 289 PRIMARY KEY,
  product_name VARCHAR2(255) NOT NULL,
  description VARCHAR2(2000),
  standard_cost NUMBER(9, 2),
  list_price NUMBER(9, 2),
  category_id NUMBER NOT NULL,
  CONSTRAINT fk_products_categories FOREIGN KEY(category_id) REFERENCES product_categories(category_id) ON DELETE CASCADE
);

-- customers
CREATE TABLE customers (
  customer_id NUMBER GENERATED BY DEFAULT AS IDENTITY START WITH 320 PRIMARY KEY,
  name VARCHAR2(255) NOT NULL,
  address VARCHAR2(255),
  website VARCHAR2(255),
  credit_limit NUMBER(8, 2)
);

-- contacts
CREATE TABLE contacts (
  contact_id NUMBER GENERATED BY DEFAULT AS IDENTITY START WITH 320 PRIMARY KEY,
  first_name VARCHAR2(255) NOT NULL,
  last_name VARCHAR2(255) NOT NULL,
  email VARCHAR2(255) NOT NULL,
  phone VARCHAR2(20),
  customer_id NUMBER,
  CONSTRAINT fk_contacts_customers FOREIGN KEY(customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- orders table
CREATE TABLE orders (
  order_id NUMBER GENERATED BY DEFAULT AS IDENTITY START WITH 106 PRIMARY KEY,
  customer_id NUMBER(6, 0) NOT NULL,
  -- fk
  status VARCHAR(20) NOT NULL,
  salesman_id NUMBER(6, 0),
  -- fk
  order_date DATE NOT NULL,
  CONSTRAINT fk_orders_customers FOREIGN KEY(customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
  CONSTRAINT fk_orders_employees FOREIGN KEY(salesman_id) REFERENCES employees(employee_id) ON DELETE
  SET
    NULL
);

-- order items
CREATE TABLE order_items (
  order_id NUMBER(12, 0),
  -- fk
  item_id NUMBER(12, 0),
  product_id NUMBER(12, 0) NOT NULL,
  -- fk
  quantity NUMBER(8, 2) NOT NULL,
  unit_price NUMBER(8, 2) NOT NULL,
  CONSTRAINT pk_order_items PRIMARY KEY(order_id, item_id),
  CONSTRAINT fk_order_items_products FOREIGN KEY(product_id) REFERENCES products(product_id) ON DELETE CASCADE,
  CONSTRAINT fk_order_items_orders FOREIGN KEY(order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

-- inventories
CREATE TABLE inventories (
  product_id NUMBER(12, 0),
  -- fk
  warehouse_id NUMBER(12, 0),
  -- fk
  quantity NUMBER(8, 0) NOT NULL,
  CONSTRAINT pk_inventories PRIMARY KEY(product_id, warehouse_id),
  CONSTRAINT fk_inventories_products FOREIGN KEY(product_id) REFERENCES products(product_id) ON DELETE CASCADE,
  CONSTRAINT fk_inventories_warehouses FOREIGN KEY(warehouse_id) REFERENCES warehouses(warehouse_id) ON DELETE CASCADE
);

-- Update

ALTER TABLE CUSTOMERS ADD (REGION_ID NUMBER );

ALTER TABLE CUSTOMERS
ADD CONSTRAINT CUSTOMERS_FK1 FOREIGN KEY
(
  REGION_ID
)
REFERENCES REGIONS
(
  REGION_ID
)
ENABLE;

ALTER TABLE EMPLOYEES ADD (REGION_ID NUMBER );

ALTER TABLE EMPLOYEES
ADD CONSTRAINT EMPLOYEES_FK1 FOREIGN KEY
(
  REGION_ID
)
REFERENCES REGIONS
(
  REGION_ID
)
ENABLE;


-- disable FK constraints
ALTER TABLE countries DISABLE CONSTRAINT fk_countries_regions;
ALTER TABLE locations DISABLE CONSTRAINT fk_locations_countries;
ALTER TABLE warehouses DISABLE CONSTRAINT fk_warehouses_locations;
ALTER TABLE employees DISABLE CONSTRAINT fk_employees_manager;
ALTER TABLE products DISABLE CONSTRAINT fk_products_categories;
ALTER TABLE contacts DISABLE CONSTRAINT fk_contacts_customers;
ALTER TABLE orders DISABLE CONSTRAINT fk_orders_customers;
ALTER TABLE orders DISABLE CONSTRAINT fk_orders_employees;
ALTER TABLE order_items DISABLE CONSTRAINT fk_order_items_products;
ALTER TABLE order_items DISABLE CONSTRAINT fk_order_items_orders;
ALTER TABLE inventories DISABLE CONSTRAINT fk_inventories_products;
ALTER TABLE inventories DISABLE CONSTRAINT fk_inventories_warehouses;
--------------------------------------------------------


--- Countries

insert into regions
select * from a01703613.regions;

insert into countries
select * from a01703613.countries
where region_id = 4;

insert into locations
select * from a01703613.locations L
where L.country_id
in
( select C.country_id from a01703613.countries C where C.region_id = 4);

insert into warehouses
select * from a01703613.warehouses W
where W.location_id
in
( select L.location_id from a01703613.locations L
where L.country_id
in
( select C.country_id from a01703613.countries C where C.region_id = 4));

insert into inventories
select * from a01703613.inventories I
where I.warehouse_id
in
( select W.warehouse_id from a01703613.warehouses W
where W.location_id
in
( select L.location_id from a01703613.locations L
where L.country_id
in
(select C.country_id from a01703613.countries C where C.region_id = 4)));

--Employees
insert into employees
select * from a01703613.employees
where region_id = 4;

--Customers
insert into customers
select * from a01703613.customers
where region_id = 4;

--Contacts
insert into contacts
select * from a01703613.contacts C
where C.customer_id
in
(select CU.customer_id from a01703613.customers CU
where CU.region_id = 4);

--Orders
insert into orders
select * from orders O
where O.customer_id
in
(select CU.customer_id from customers CU
where CU.region_id = 4);

--order_items
insert into order_items
select * from a01703613.order_items OT
where OT.order_id
in
(select O.order_id from a01703613.orders O
where O.customer_id
in
( select CU.customer_id from a01703613.customers CU
where CU.region_id = 4));

--products
insert into products
select * from a01703613.products;

--product_categories
insert into product_categories
select * from a01703613.product_categories;

-- enable FK constraints
ALTER TABLE countries ENABLE CONSTRAINT fk_countries_regions;
ALTER TABLE locations ENABLE CONSTRAINT fk_locations_countries;
ALTER TABLE warehouses ENABLE CONSTRAINT fk_warehouses_locations;
ALTER TABLE employees ENABLE CONSTRAINT fk_employees_manager;
ALTER TABLE products ENABLE CONSTRAINT fk_products_categories;
ALTER TABLE contacts ENABLE CONSTRAINT fk_contacts_customers;
ALTER TABLE orders ENABLE CONSTRAINT fk_orders_customers;
ALTER TABLE orders ENABLE CONSTRAINT fk_orders_employees;
ALTER TABLE order_items ENABLE CONSTRAINT fk_order_items_products;
ALTER TABLE order_items ENABLE CONSTRAINT fk_order_items_orders;
ALTER TABLE inventories ENABLE CONSTRAINT fk_inventories_products;
ALTER TABLE inventories ENABLE CONSTRAINT fk_inventories_warehouses;