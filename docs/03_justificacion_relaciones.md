# Justificación de las Relaciones del Sistema

Este documento explica cómo se relacionan entre sí las tablas de nuestra base de datos, indicando la cardinalidad, la llave foránea que hace posible la conexión y la regla de negocio que le da origen.

---

## 1. Relaciones de Catálogos y Productos

### Categorías y Productos (`categorias` 1 : N `productos`)
* **Cardinalidad:** 1 a Muchos (Una categoría agrupa muchos productos; un producto pertenece a una sola categoría).
* **Llave Foránea:** `id_categoria` en la tabla `productos`.
* **Regla de Negocio:** Para mantener el inventario ordenado, todo artículo que se vende en el negocio debe pertenecer obligatoriamente a una clasificación o departamento específico (por ejemplo: herramientas, fontanería o electricidad).

### Marcas y Productos (`marcas` 1 : N `productos`)
* **Cardinalidad:** 1 a Muchos (Una marca identifica a muchos productos; un producto pertenece a una sola marca principal).
* **Llave Foránea:** `id_marca` en la tabla `productos`.
* **Regla de Negocio:** Es necesario conocer el fabricante o marca comercial de cada artículo para brindar información clara al cliente y gestionar garantías o compras.

### Ubicaciones y Productos (`ubicaciones` 1 : N `productos`)
* **Cardinalidad:** 1 a Muchos (Una ubicación de la bodega o pasillo almacena muchos productos).
* **Llave Foránea:** `id_ubicacion` en la tabla `productos`.
* **Regla de Negocio:** Para agilizar la búsqueda de la mercancía física dentro del negocio, cada producto debe estar asignado a una coordenada específica (como un estante o pasillo).

### Proveedores, Productos y la Tabla Puente (`productos_proveedores` M : N)
* **Cardinalidad:** Muchos a Muchos (Un producto puede ser surtido por varios proveedores y un proveedor puede suministrar muchos productos distintos).
* **Llave Foránea:** `id_producto` e `id_proveedor` en la tabla intermedia `productos_proveedores`.
* **Regla de Negocio:** Como un mismo artículo se le puede comprar a diferentes distribuidores según precio o disponibilidad, se implementó una tabla intermedia para evitar duplicar información y registrar con qué proveedor cuenta cada producto.

---

## 2. Relaciones del Proceso de Facturación y Clientes

### Clientes y Facturas Encabezado (`clientes` 1 : N `facturas_encabezado`)
* **Cardinalidad:** 1 a Muchos (Un cliente puede tener muchas facturas registradas a su nombre a lo largo del tiempo).
* **Llave Foránea:** `id_cliente` en la tabla `facturas_encabezado`.
* **Regla de Negocio:** Cada venta que se emite debe estar vinculada a quién se le vendió (ya sea un cliente registrado con su NIT o el genérico Consumidor Final "CF") para llevar un historial de compras.

### Empleados y Facturas Encabezado (`empleados` 1 : N `facturas_encabezado`)
* **Cardinalidad:** 1 a Muchos (Un empleado o vendedor puede emitir o atender muchas facturas).
* **Llave Foránea:** `id_empleado` en la tabla `facturas_encabezado`.
* **Regla de Negocio:** El negocio necesita saber qué vendedor realizó la transacción para efectos de control interno o comisiones.

### Métodos de Pago y Pagos Factura (`metodos_pago` 1 : N `pagos_factura`)
* **Cardinalidad:** 1 a Muchos (Un método de pago se usa en múltiples transacciones de cobro).
* **Llave Foránea:** `id_metodo_pago` en la tabla `pagos_factura`.
* **Regla de Negocio:** Cada cobro realizado debe especificar con qué medio pagó el cliente (efectivo, tarjeta, etc.) para cuadrar caja correctamente.

---

## 3. ¿Por qué `FACTURAS_DETALLE` es la tabla puente entre Facturas y Productos?

En un sistema de ventas, nos enfrentamos a una relación de **Muchos a Muchos (M:N)**:
1. Una factura de venta (`facturas_encabezado`) puede incluir **muchos productos** diferentes.
2. Un producto (`productos`) puede aparecer en **muchas facturas** distintas a lo largo del tiempo.

En bases de datos relacionales, una relación de muchos a muchos no se puede conectar directamente con una sola flecha. Si intentáramos meter los productos directo en la factura,se saturarían las columnas; y si se metiera la factura en el producto, no se podría vender varios artículos a la vez.

**Solución:** Se creó la tabla puente **`facturas_detalle`**, la cual cumple con lo siguiente:
* Rompe la relación M:N convirtiéndola en dos relaciones de **1 a Muchos**:
  * `facturas_encabezado` (1) $\rightarrow$ `facturas_detalle` (N)
  * `productos` (1) $\rightarrow$ `facturas_detalle` (N)
* Almacena datos propios de esa transacción específica que no residen en el catálogo de productos, tales como:
  * La **cantidad** exacta que compró el cliente en ese momento.
  * El **precio unitario** vigente al momento de la venta.
  * El **subtotal** calculado automáticamente (`cantidad * precio_unitario`), asegurando que se cumplan las reglas de normalización (3FN) sin depender de cambios futuros en los precios del catálogo.

  