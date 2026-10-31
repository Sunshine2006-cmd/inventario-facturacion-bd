-- Carga de Catálogos

-- 3 inserts a categorías
INSERT INTO categorias (nombre_categoria, descripcion) VALUES ('Herramientas Manuales', 'Herramientas de uso general');
INSERT INTO categorias (nombre_categoria, descripcion) VALUES ('Fontanería', 'Tubos, conexiones y accesorios');
INSERT INTO categorias (nombre_categoria, descripcion) VALUES ('Electricidad', 'Cables, enchufes y breakers');

-- 3 inserts a marcas
INSERT INTO marcas (nombre_marca) VALUES ('Truper');
INSERT INTO marcas (nombre_marca) VALUES ('Stanley');
INSERT INTO marcas (nombre_marca) VALUES ('Square D');

-- 2 inserts de ubicaciones
INSERT INTO ubicaciones (codigo_ubicacion, descripcion) VALUES ('PASILLO-A1', 'Estante principal de herramientas');
INSERT INTO ubicaciones (codigo_ubicacion, descripcion) VALUES ('PASILLO-B2', 'Sección de tuberías y conexiones');

-- 2 inserts de proveedores
INSERT INTO proveedores (nit_empresa, nombre_empresa, telefono, contacto_principal) VALUES ('123456-7', 'Ferretera Global S.A.', '22334455', 'Carlos Gómez');
INSERT INTO proveedores (nit_empresa, nombre_empresa, telefono, contacto_principal) VALUES ('987654-3', 'Distribuidora Eléctrica del Norte', '55443322', 'Ana Morales');

-- 2 inserts de clientes
INSERT INTO clientes (nit, nombre_completo, direccion, telefono) VALUES ('CF', 'Consumidor Final', 'Ciudad', '00000000');
INSERT INTO clientes (nit, nombre_completo, direccion, telefono) VALUES ('456789-1', 'Juan Pérez', 'Zona 1, Mixco', '55112233');

-- 2 inserts de empleados
INSERT INTO empleados (nombre_completo, cargo) VALUES ('María Rodríguez', 'Vendedor');
INSERT INTO empleados (nombre_completo, cargo) VALUES ('Pedro Solares', 'Bodeguero');

-- 2 inserts de metodos de pago
INSERT INTO metodos_pago (nombre_metodo) VALUES ('Efectivo');
INSERT INTO metodos_pago (nombre_metodo) VALUES ('Tarjeta de Crédito');

-- Productos iniciales

-- 2 inserts de productos
INSERT INTO productos (codigo_barras, nombre_producto, precio_compra, precio_venta, stock_actual, id_categoria, id_marca, id_ubicacion) 
VALUES ('PRD-001', 'Martillo uña 16oz', 45.00, 75.00, 25, 1, 1, 1);

INSERT INTO productos (codigo_barras, nombre_producto, precio_compra, precio_venta, stock_actual, id_categoria, id_marca, id_ubicacion) 
VALUES ('PRD-002', 'Cable eléctrico #12 (Rollo)', 180.00, 250.00, 10, 3, 3, 2);

-- Relación Productos y Proveedores (Muchos a Muchos)
INSERT INTO productos_proveedores (id_producto, id_proveedor) VALUES (1, 1);
INSERT INTO productos_proveedores (id_producto, id_proveedor) VALUES (2, 2);

COMMIT;