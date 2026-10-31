# Guía Paso a Paso para la Reproducción del Proyecto

Esta guía contiene los requerimientos e instrucciones necesarias para desplegar la base de datos del **Sistema de Inventario y Facturación** desde cero en cualquier entorno de trabajo.

---

## 1. Requisitos Previos

Para ejecutar y probar el proyecto correctamente, asegúrese de contar con las siguientes herramientas instaladas y configuradas:

* **Motor de Base de Datos:** Oracle Database / PostgreSQL (según el entorno donde se ejecute el script con soporte para sintaxis SQL estándar y tipos de datos `NUMBER`/`VARCHAR2`/`TIMESTAMP`).
* **Cliente SQL Recomendado:** DBeaver Community (Versión 26.2.0 o superior).
* **Credenciales de Acceso:** Usuario con privilegios para crear tablas, restricciones (`CONSTRAINTS`) y ejecutar sentencias DDL/DML.

---

## 2. Orden de Ejecución de Scripts

Los scripts SQL están organizados de forma secuencial dentro de la carpeta `sql/` para garantizar que las dependencias entre tablas y llaves foráneas se creen en la secuencia adecuada:

1. **`sql/01_ddl_crear_base_datos.sql`**
   * **Propósito:** Realiza la preparación del esquema/base de datos e incluye una limpieza previa eliminando tablas existentes en orden inverso a sus dependencias para evitar conflictos.

2. **`sql/01_ddl_crear_tablas.sql`**
   * **Propósito:** Crea la estructura de las 15 tablas del sistema (7 catálogos y 8 transaccionales/puentes), aplicando llaves primarias (`PK`), llaves foráneas (`FK`), valores por defecto (`DEFAULT`) y reglas de validación (`CHECK`, `UNIQUE`, `NOT NULL`).Se aplica a la vez la lógica programada que sostendrá distintos procesos automáticos como lo son la actualización de stock, el manejo de factoras, etc. Se crean vistas y demás similares que son de utilidad para el usuario que maneja la base de datos.

3. **`sql/03_dml_datos_prueba.sql`**
   * **Propósito:** Puebla la base de datos con registros iniciales de prueba (categorías, marcas, clientes, productos con existencias, facturas, compras y movimientos de inventario).

4. **`sql/04_consultas_reportes.sql`**
   * **Propósito:** Ejecuta las consultas operativas y de reporte clave (alertas de bajo stock, facturación por cliente, ventas por producto, e inventario valorizado por proveedor).

---

## 3. Verificación de la Creación Correcta

Una vez ejecutados los scripts DDL y DML, puedes validar que el entorno se construyó sin errores siguiendo estos pasos:

### A. Listar la cantidad de tablas creadas
Ejecuta la siguiente consulta para verificar que existan exactamente las 15 tablas requeridas:

```sql
SELECT table_name 
FROM user_tables 
WHERE LOWER(table_name) IN (
    'categorias', 'marcas', 'ubicaciones', 'proveedores', 'clientes', 
    'empleados', 'metodos_pago', 'productos', 'productos_proveedores', 
    'movimientos_inventario', 'compras_encabezado', 'compras_detalle', 
    'facturas_encabezado', 'facturas_detalle', 'pagos_factura'
)
ORDER BY table_name;
```

### B. Contar registros por tabla
Ejecuta una validación rápida del conteo de filas en los catálogos y tablas principales:

```sql
SELECT 'categorias' AS tabla, COUNT(*) AS total FROM categorias
UNION ALL
SELECT 'marcas', COUNT(*) FROM marcas
UNION ALL
SELECT 'ubicaciones', COUNT(*) FROM ubicaciones
UNION ALL
SELECT 'proveedores', COUNT(*) FROM proveedores
UNION ALL
SELECT 'clientes', COUNT(*) FROM clientes
UNION ALL
SELECT 'empleados', COUNT(*) FROM empleados
UNION ALL
SELECT 'metodos_pago', COUNT(*) FROM metodos_pago
UNION ALL
SELECT 'productos', COUNT(*) FROM productos
UNION ALL
SELECT 'facturas_encabezado', COUNT(*) FROM facturas_encabezado;
```

---

## 4. Capturas de Pantalla de Resultados Esperados

*(En esta sección se deben incluir las capturas almacenadas en la carpeta `capturas/` de tu repositorio).*

### Ejemplo de Estructura de Tablas Creadas
> `![Lista de Tablas](capturas/01_lista_tablas.png)`  
> *Muestra la lista completa de las 15 tablas visualizadas desde el navegador de DBeaver.*

### Ejemplo de Consulta de Reporte (Productos con Bajo Stock)
> `![Reporte Bajo Stock](capturas/02_reporte_bajo_stock.png)`  
> *Muestra el resultado de la consulta SQL obteniendo los productos cuyo stock está por debajo del límite mínimo.*

---

## 5. Problemas Comunes y Soluciones

| Problema / Error | Causa Probable | Solución Sugerida |
| :--- | :--- | :--- |
| **`ORA-02292: integrity constraint violated - child record found`** | Se intentó eliminar o truncar una tabla catálogo que ya tiene datos asociados en tablas fijas (como `productos` o `facturas_encabezado`). | Ejecuta los scripts en el orden numerado indicado (`01` $\rightarrow$ `02` $\rightarrow$ `03`). |
| **`ORA-00001: unique constraint violated`** | Se intentó insertar un registro con un `codigo_barras`, `nit_empresa` o `nombre_categoria` que ya existe. | Limpia la base de datos volviendo a ejecutar el script `sql/01_ddl_crear_base_datos.sql` antes de insertar los datos de prueba. |
| **`Error de sintaxis en columnas calculadas (subtotal)`** | Versión de motor SQL incompatible con `GENERATED ALWAYS AS`. | Asegúrate de usar DBeaver con un conector compatible con Oracle 12c+ o PostgreSQL 12+. |
