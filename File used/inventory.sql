-- inventory.sql
-- Create products table and insert sample rows
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id TEXT PRIMARY KEY,
    product_name TEXT NOT NULL,
    category TEXT,
    price REAL,
    stock INTEGER
);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P001', 'Product_001', 'Grocery', 264.89, 371);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P002', 'Product_002', 'Grocery', 605.91, 150);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P003', 'Product_003', 'Beauty', 3027.98, 127);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P004', 'Product_004', 'Toys', 2600.12, 229);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P005', 'Product_005', 'Books', 1178.99, 18);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P006', 'Product_006', 'Clothing', 3250.7, 481);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P007', 'Product_007', 'Books', 2084.59, 134);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P008', 'Product_008', 'Books', 4534.16, 161);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P009', 'Product_009', 'Clothing', 1799.44, 163);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P010', 'Product_010', 'Sports', 1315.44, 77);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P011', 'Product_011', 'Electronics', 1410.29, 28);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P012', 'Product_012', 'Sports', 4263.31, 176);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P013', 'Product_013', 'Beauty', 3354.37, 155);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P014', 'Product_014', 'Beauty', 3844.95, 467);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P015', 'Product_015', 'Books', 2286.25, 251);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P016', 'Product_016', 'Books', 807.27, 58);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P017', 'Product_017', 'Beauty', 3697.53, 235);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P018', 'Product_018', 'Electronics', 2390.82, 158);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P019', 'Product_019', 'Home', 523.79, 441);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P020', 'Product_020', 'Toys', 1595.75, 428);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P021', 'Product_021', 'Books', 3055.12, 169);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P022', 'Product_022', 'Electronics', 3207.91, 466);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P023', 'Product_023', 'Books', 1984.98, 450);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P024', 'Product_024', 'Home', 2509.0, 267);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P025', 'Product_025', 'Electronics', 1408.97, 272);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P026', 'Product_026', 'Beauty', 3490.97, 332);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P027', 'Product_027', 'Toys', 2241.45, 134);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P028', 'Product_028', 'Home', 3602.11, 250);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P029', 'Product_029', 'Clothing', 128.31, 289);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P030', 'Product_030', 'Home', 685.55, 28);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P031', 'Product_031', 'Grocery', 3035.94, 111);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P032', 'Product_032', 'Books', 2913.02, 176);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P033', 'Product_033', 'Clothing', 3874.48, 45);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P034', 'Product_034', 'Books', 474.01, 362);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P035', 'Product_035', 'Sports', 2998.97, 82);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P036', 'Product_036', 'Sports', 1650.69, 388);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P037', 'Product_037', 'Clothing', 1750.62, 496);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P038', 'Product_038', 'Home', 393.65, 58);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P039', 'Product_039', 'Grocery', 4167.72, 453);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P040', 'Product_040', 'Grocery', 4011.76, 36);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P041', 'Product_041', 'Home', 3218.83, 273);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P042', 'Product_042', 'Home', 4406.39, 59);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P043', 'Product_043', 'Home', 3416.65, 309);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P044', 'Product_044', 'Beauty', 1655.45, 268);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P045', 'Product_045', 'Grocery', 992.11, 139);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P046', 'Product_046', 'Toys', 4970.99, 267);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P047', 'Product_047', 'Electronics', 1846.57, 300);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P048', 'Product_048', 'Clothing', 3666.72, 295);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P049', 'Product_049', 'Home', 1701.17, 159);
INSERT INTO products (product_id, product_name, category, price, stock) VALUES ('P050', 'Product_050', 'Toys', 2833.37, 45);