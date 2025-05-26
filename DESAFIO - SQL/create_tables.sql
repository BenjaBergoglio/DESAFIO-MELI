CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    sexo CHAR(1),
    direccion TEXT,
    fecha_nacimiento DATE,
    telefono VARCHAR(20)
);

CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    parent_category_id INT NULL,
    FOREIGN KEY (parent_category_id) REFERENCES Category(category_id)
);

CREATE TABLE Item (
    item_id INT PRIMARY KEY,
    seller_id INT,
    category_id INT,
    titulo VARCHAR(255),
    precio DECIMAL(10, 2),
    estado VARCHAR(50),
    fecha_alta DATE,
    fecha_baja DATE,
    FOREIGN KEY (seller_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE "Orders" (
    order_id INT PRIMARY KEY,
    item_id INT,
    buyer_id INT,
    seller_id INT,
    cantidad INT,
    precio_unitario DECIMAL(10, 2),
    fecha DATE,
    FOREIGN KEY (item_id) REFERENCES Item(item_id),
    FOREIGN KEY (buyer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (seller_id) REFERENCES Customer(customer_id)
);

-- Tabla adicional para ítems al final del día
CREATE TABLE Item_Estado_Historico (
    fecha_registro DATE,
    item_id INT,
    precio DECIMAL(10, 2),
    estado VARCHAR(50),
    PRIMARY KEY (fecha_registro, item_id)
);
