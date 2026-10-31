---
output:
  pdf_document: default
  html_document: default
---
# Sistema de Inventario y Facturación

---

## Información General

* **Curso:** Base de Datos I  
* **Motor de Base de Datos:** Oracle data base (DBeaver versión 26.2.0)
* **Alumna:** Sol Arely Martínez García  
* **Carnet:** 7590-24-4829
* **Fecha:** 31/10/2026  
---

## Descripción Breve del Sistema y Alcance

### Descripción
Este proyecto consiste en el diseño e implementación de una base de datos relacional para gestionar el control de inventario y el proceso de facturación en un negocio comercial (enfocado en una ferretería). El sistema permite administrar los datos principales de la tienda (productos, categorías, proveedores y clientes) y llevar un registro detallado de cada venta que se realiza.

### Alcance del Sistema
* **Gestión de Catálogos:** Registro y consulta de categorías de productos, proveedores y clientes.
* **Control de Inventario:** Manejo de existencias (stock actual), precios de compra y venta, vinculados con sus respectivas categorías y proveedores.
* **Proceso de Facturación:** Registro completo de ventas con encabezado (datos de la factura y cliente) y detalle línea por línea (productos comprados, cantidades y subtotales).
* **Automatización Integrada:** Actualización automática del stock disponible y cálculo de totales mediante la lógica implementada en la base de datos
* **Reportes y Consultas:** Generación de reportes clave para la toma de decisiones, tales como productos con bajo stock, historial de ventas por cliente, productos más vendidos e inventario valorizado por proveedor.

---

## Instrucciones Rápidas de Ejecución

Para montar la base de datos desde cero en el entorno local con DBeaver o cliente SQL preferido, seguirestos pasos ejecutando los scripts ubicados en la carpeta `sql/` en el orden exacto indicado:

1. **Crear la Base de Datos:**  
   Ejecuta el script `sql/01_ddl_crear_base_datos.sql` para preparar el espacio de trabajo.

2. **Crear la Estructura de Tablas:**  
   Ejecuta el archivo `sql/02_ddl_crear_tablas.sql`. Este script genera todas las tablas necesarias con sus respectivas llaves primarias, llaves foráneas y reglas de validación (restricciones).

3. **Cargar Datos de Prueba:**  
   Ejecuta `sql/03_dml_datos_prueba.sql` para poblar el sistema con información inicial (catálogos de clientes, proveedores, categorías, productos con stock y facturas de ejemplo).

4. **Probar Reportes y Consultas:**  
   Abre y ejecuta `sql/04_consultas_reportes.sql` para verificar el correcto funcionamiento del sistema y visualizar los reportes generados.

## Diagrama Entidad-Relación

* `![Diagrama Entidad-Relación](img/modelo_er.png)`

---

## Índice de Documentos y Scripts

```text
├── capturas/                  
│   ├── 01_lista_tablas.png
│   └── 02_reporte_bajo_stock.png
├── docs/                      
│   ├── 01_descripcion_sistema.md
│   ├── 02_diccionario_datos.md
│   ├── 03_justificacion_relaciones.md
│   ├── 04_normalizacion.md
│   └── 05_paso_a_paso.md
├── img/                       
│   ├── modelo_er.png
│   └── modelo_relacional.png
└── sql/                       
    ├── 01_ddl_crear_base_datos.sql
    ├── 02_ddl_crear_tablas.sql
    ├── 03_dml_datos_prueba.sql
    └── 04_consultas_reportes.sql