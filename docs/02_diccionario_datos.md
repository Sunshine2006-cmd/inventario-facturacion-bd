# Diccionario de Datos - Sistema de Inventario y Facturación

---

## Tablas de Catálogo y Soporte Base

Estas tablas almacenan la información principal e independiente que alimenta el sistema (como clasificaciones, marcas, lugares, proveedores, clientes, empleados y métodos de pago).

### 1. Categorías (`categorias`)
Almacena la clasificación general para agrupar los artículos del negocio.

| Nombre del Campo | Tipo de Dato | Llave | Descripción | Restricciones |
| :--- | :--- | :---: | :--- | :--- |
| `id_categoria` | `NUMBER` | **PK** | Identificador único autoincrementable | `NOT NULL` |
| `nombre_categoria` | `VARCHAR2(50)` | | Nombre comercial o tipo de categoría | `UNIQUE, NOT NULL` |
| `descripcion` | `VARCHAR2(150)` | | Detalles adicionales sobre lo que abarca la categoría | *Opcional* |

---

### 2. Marcas (`marcas`)
Guarda las marcas o fabricantes de los productos que se venden.

| Nombre del Campo | Tipo de Dato | Llave | Descripción | Restricciones |
| :--- | :--- | :---: | :--- | :--- |
| `id_marca` | `NUMBER` | **PK** | Identificador único de la marca | `NOT NULL` |
| `nombre_marca` | `VARCHAR2(50)` | | Nombre del fabricante o marca | `UNIQUE, NOT NULL` |

---

### 3. Ubicaciones (`ubicaciones`)
Sirve para ubicar físicamente el stock dentro de la ferretería o supermercado (estantes, pasillos o bodegas).

| Nombre del Campo | Tipo de Dato | Llave | Descripción | Restricciones |
| :--- | :--- | :---: | :--- | :--- |
| `id_ubicacion` | `NUMBER` | **PK** | Identificador único de la ubicación | `NOT NULL` |
| `codigo_ubicacion` | `VARCHAR2(20)` | | Código corto para el pasillo o estante | `UNIQUE, NOT NULL` |
| `descripcion` | `VARCHAR2(100)` | | Descripción de la zona o sección | *Opcional* |

---

### 4. Proveedores (`proveedores`)
Contiene los datos de las empresas que surten los productos al negocio.

| Nombre del Campo | Tipo de Dato | Llave | Descripción | Restricciones |
| :--- | :--- | :---: | :--- | :--- |
| `id_proveedor` | `NUMBER` | **PK** | Identificador único del proveedor | `NOT NULL` |
| `nit_empresa` | `VARCHAR2(15)` | | Número de identificación tributaria de la empresa | `UNIQUE, NOT NULL` |
| `nombre_empresa` | `VARCHAR2(100)` | | Nombre comercial del proveedor | `NOT NULL` |
| `telefono` | `VARCHAR2(15)` | | Teléfono de contacto | `NOT NULL` |
| `contacto_principal` | `VARCHAR2(100)` | | Nombre de la persona encargada o agente de ventas | *Opcional* |

---

### 5. Clientes (`clientes`)
Registra la información de las personas o empresas que compran en el negocio.

| Nombre del Campo | Tipo de Dato | Llave | Descripción | Restricciones |
| :--- | :--- | :---: | :--- | :--- |
| `id_cliente` | `NUMBER` | **PK** | Identificador único del cliente | `NOT NULL` |
| `nit` | `VARCHAR2(15)` | | NIT del cliente (por defecto se usa 'CF' para consumidor final) | `DEFAULT 'CF', NOT NULL` |
| `nombre_completo` | `VARCHAR2(100)` | | Nombre de la persona o razón social | `NOT NULL` |
| `direccion` | `VARCHAR2(200)` | | Dirección de entrega o domicilio | *Opcional* |
| `telefono` | `VARCHAR2(15)` | | Número de teléfono de contacto | *Opcional* |

---

### 6. Empleados (`empleados`)
Guarda al personal que labora en el negocio y que emite las facturas.

| Nombre del Campo | Tipo de Dato | Llave | Descripción | Restricciones |
| :--- | :--- | :---: | :--- | :--- |
| `id_empleado` | `NUMBER` | **PK** | Identificador único del empleado | `NOT NULL` |
| `nombre_completo` | `VARCHAR2(100)` | | Nombre del trabajador | `NOT NULL` |
| `cargo` | `VARCHAR2(50)` | | Puesto que desempeña (ej. Vendedor, Bodeguero) | `NOT NULL` |

---

### 7. Métodos de Pago (`metodos_pago`)
Define las formas en que los clientes pueden pagar sus facturas (Efectivo, Tarjeta, etc.).

| Nombre del Campo | Tipo de Dato | Llave | Descripción | Restricciones |
| :--- | :--- | :---: | :--- | :--- |
| `id_metodo_pago` | `NUMBER` | **PK** | Identificador único del método de pago | `NOT NULL` |
| `nombre_metodo` | `VARCHAR2(50)` | | Nombre de la forma de pago | `UNIQUE, NOT NULL` |

---

## Tablas Transaccionales, de Productos y Puentes

Estas tablas registran la operación diaria del negocio, los movimientos de mercadería, las compras a proveedores y las ventas a clientes.

### 8. Productos (`productos`)
Es el catálogo principal de artículos disponibles para la venta.

| Nombre del Campo | Tipo de Dato | Llave | Descripción | Restricciones |
| :--- | :--- | :---: | :--- | :--- |
| `id_producto` | `NUMBER` | **PK** | Identificador interno del producto | `NOT NULL` |
| `codigo_barras` | `VARCHAR2(50)` | | Código impreso en el empaque del artículo | `UNIQUE, NOT NULL` |
| `nombre_producto` | `VARCHAR2(100)` | | Nombre o descripción corta del artículo | `NOT NULL` |
| `precio_compra` | `NUMBER(10,2)` | | Costo unitario en que se adquiere al proveedor | `CHECK (> 0)` |
| `precio_venta` | `NUMBER(10,2)` | | Precio final al público | `CHECK (> 0)` |
| `stock_actual` | `NUMBER` | | Cantidad de unidades físicas disponibles en bodega | `CHECK (>= 0)` |
| `id_categoria` | `NUMBER` | **FK** | Conecta con la tabla `categorias` | `NOT NULL` |
| `id_marca` | `NUMBER` | **FK** | Conecta con la tabla `marcas` | `NOT NULL` |
| `id_ubicacion` | `NUMBER` | **FK** | Conecta con la tabla `ubicaciones` | `NOT NULL` |

---

### 9. Productos - Proveedores (`productos_proveedores`)
Tabla intermedia que resuelve la relación de muchos a muchos entre los productos y sus proveedores.

| Nombre del Campo | Tipo de Dato | Llave | Descripción | Restricciones |
| :--- | :--- | :---: | :--- | :--- |
| `id_prod_prov` | `NUMBER` | **PK** | Identificador único de la relación | `NOT NULL` |
| `id_producto` | `NUMBER` | **FK** | Conecta con la tabla `productos` | `NOT NULL` |
| `id_proveedor` | `NUMBER` | **FK** | Conecta con la tabla `proveedores` | `NOT NULL` |

---

### 10. Movimientos de Inventario (`movimientos_inventario`)
Lleva el historial y control estricto de entradas, salidas, devoluciones, productos dañados o ajustes manuales.

| Nombre del Campo | Tipo de Dato | Llave | Descripción | Restricciones |
| :--- | :--- | :---: | :--- | :--- |
| `id_movimiento` | `NUMBER` | **PK** | Identificador único del movimiento | `NOT NULL` |
| `id_producto` | `NUMBER` | **FK** | Conecta con la tabla `productos` | `NOT NULL` |
| `tipo_movimiento` | `VARCHAR2(20)` | | Tipo (ENTRADA, SALIDA, DEVOLUCION, DAÑADO, AJUSTE) | `CHECK IN (...)`, `NOT NULL` |
| `cantidad` | `NUMBER` | | Cantidad de unidades afectadas | `CHECK (> 0), NOT NULL` |
| `stock_anterior` | `NUMBER` | | Cantidad de stock antes del movimiento | `CHECK (>= 0), NOT NULL` |
| `stock_nuevo` | `NUMBER` | | Stock resultante después del cambio | `CHECK (>= 0), NOT NULL` |
| `fecha_movimiento` | `TIMESTAMP` | | Fecha y hora exacta del registro | `DEFAULT CURRENT_TIMESTAMP` |
| `referencia` | `VARCHAR2(100)` | | Número de factura, orden de compra o motivo | *Opcional* |

---

### 11. Compras Encabezado (`compras_encabezado`)
Almacena la información general de las facturas o notas de compra recibidas de los proveedores.

| Nombre del Campo | Tipo de Dato | Llave | Descripción | Restricciones |
| :--- | :--- | :---: | :--- | :--- |
| `id_compra` | `NUMBER` | **PK** | Identificador único de la orden de compra | `NOT NULL` |
| `numero_factura_proveedor` | `VARCHAR2(50)` | | Número del documento fiscal del proveedor | `NOT NULL` |
| `fecha_compra` | `TIMESTAMP` | | Fecha en que ingresó la compra | `DEFAULT CURRENT_TIMESTAMP` |
| `total_compra` | `NUMBER(10,2)` | | Monto global pagado al proveedor | `DEFAULT 0` |
| `id_proveedor` | `NUMBER` | **FK** | Conecta con la tabla `proveedores` | `NOT NULL` |

---

### 12. Compras Detalle (`compras_detalle`)
Registra la lista de productos específicos adquiridos en cada compra a proveedores.

| Nombre del Campo | Tipo de Dato | Llave | Descripción | Restricciones |
| :--- | :--- | :---: | :--- | :--- |
| `id_detalle_compra` | `NUMBER` | **PK** | Identificador único de la línea de detalle | `NOT NULL` |
| `id_compra` | `NUMBER` | **FK** | Conecta con `compras_encabezado` | `NOT NULL` |
| `id_producto` | `NUMBER` | **FK** | Conecta con la tabla `productos` | `NOT NULL` |
| `cantidad` | `NUMBER` | | Cantidad de unidades compradas | `CHECK (> 0), NOT NULL` |
| `precio_costo_unidad` | `NUMBER(10,2)` | | Costo unitario pagado en esa compra | `NOT NULL` |
| `subtotal` | `NUMBER(10,2)` | | Campo calculado (`cantidad * precio_costo_unidad`) | `GENERATED ALWAYS AS (...)` |

---

### 13. Facturas Encabezado (`facturas_encabezado`)
Registra los datos generales de cada venta realizada a un cliente.

| Nombre del Campo | Tipo de Dato | Llave | Descripción | Restricciones |
| :--- | :--- | :---: | :--- | :--- |
| `id_factura` | `NUMBER` | **PK** | Identificador único de la venta | `NOT NULL` |
| `numero_factura` | `VARCHAR2(20)` | | Número o serie asignada al documento de venta | `UNIQUE, NOT NULL` |
| `fecha_emision` | `TIMESTAMP` | | Fecha y hora en que se emitió la factura | `DEFAULT CURRENT_TIMESTAMP` |
| `total_factura` | `NUMBER(10,2)` | | Monto total a pagar por el cliente | `DEFAULT 0` |
| `id_cliente` | `NUMBER` | **FK** | Conecta con la tabla `clientes` | `NOT NULL` |
| `id_empleado` | `NUMBER` | **FK** | Conecta con la tabla `empleados` | `NOT NULL` |

---

### 14. Facturas Detalle (`facturas_detalle`)
Detalla los productos específicos, cantidades y precios incluidos en cada factura de venta.

| Nombre del Campo | Tipo de Dato | Llave | Descripción | Restricciones |
| :--- | :--- | :---: | :--- | :--- |
| `id_detalle` | `NUMBER` | **PK** | Identificador único de la línea de venta | `NOT NULL` |
| `id_factura` | `NUMBER` | **FK** | Conecta con `facturas_encabezado` | `NOT NULL` |
| `id_producto` | `NUMBER` | **FK** | Conecta con la tabla `productos` | `NOT NULL` |
| `cantidad` | `NUMBER` | | Unidades del producto compradas por el cliente | `CHECK (> 0), NOT NULL` |
| `precio_unitario` | `NUMBER(10,2)` | | Precio de venta asignado al producto | `NOT NULL` |
| `subtotal` | `NUMBER(10,2)` | | Campo calculated (`cantidad * precio_unitario`) | `GENERATED ALWAYS AS (...)` |

---

### 15. Pagos Factura (`pagos_factura`)
Controla la forma en que el cliente cancela su factura (efectivo, tarjeta, etc.).

| Nombre del Campo | Tipo de Dato | Llave | Descripción | Restricciones |
| :--- | :--- | :---: | :--- | :--- |
| `id_pago` | `NUMBER` | **PK** | Identificador único del cobro | `NOT NULL` |
| `monto` | `NUMBER(10,2)` | | Cantidad de dinero recibida para cubrir la factura | `CHECK (> 0)` |
| `id_factura` | `NUMBER` | **FK** | Conecta con `facturas_encabezado` | `NOT NULL` |
| `id_metodo_pago` | `NUMBER` | **FK** | Conecta con la tabla `metodos_pago` | `NOT NULL` |