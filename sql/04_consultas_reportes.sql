-- 1. Top de Productos más Vendidos
SELECT p.nombre_producto, SUM(fd.cantidad) AS total_vendido, SUM(fd.subtotal) AS monto_generado
FROM facturas_detalle fd
JOIN productos p ON fd.id_producto = p.id_producto
GROUP BY p.nombre_producto
ORDER BY total_vendido DESC;

-- 2. Reporte Consolidado por Cliente
SELECT c.nombre_completo, c.nit, COUNT(f.id_factura) AS frecuencia_compras, 
       SUM(f.total_factura) AS total_gastado, AVG(f.total_factura) AS promedio_compra
FROM clientes c
LEFT JOIN facturas_encabezado f ON c.id_cliente = f.id_cliente
GROUP BY c.nombre_completo, c.nit;

-- 3. Resumen de Compras a Proveedores clasificado por Categoría
SELECT pr.nombre_empresa, cat.nombre_categoria, SUM(cd.cantidad) AS total_comprado, SUM(cd.subtotal) AS inversion_total
FROM compras_encabezado ce
JOIN proveedores pr ON ce.id_proveedor = pr.id_proveedor
JOIN compras_detalle cd ON ce.id_compra = cd.id_compra
JOIN productos p ON cd.id_producto = p.id_producto
JOIN categorias cat ON p.id_categoria = cat.id_categoria
GROUP BY pr.nombre_empresa, cat.nombre_categoria;

-- 4. Kárdex / Historial de Movimientos de Inventario
SELECT p.nombre_producto, m.tipo_movimiento, m.cantidad, m.stock_anterior, m.stock_nuevo, m.fecha_movimiento, m.referencia
FROM movimientos_inventario m
JOIN productos p ON m.id_producto = p.id_producto
ORDER BY m.fecha_movimiento DESC;

-- 5. Cierre de Caja por Forma de Pago
SELECT mp.nombre_metodo, COUNT(pf.id_pago) AS cantidad_transacciones, SUM(pf.monto) AS total_recaudado
FROM pagos_factura pf
JOIN metodos_pago mp ON pf.id_metodo_pago = mp.id_metodo_pago
GROUP BY mp.nombre_metodo;