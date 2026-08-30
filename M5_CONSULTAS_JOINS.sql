--MODULO 5- CONSULTAS CON JOINS--
--PROYECTO: VENTAS TECH--
--ESTUDIANTE: DANIELA DE TORRRES--

--USAMOS LA BASE DE DATOS VENTAS TECH--
USE Ventas_Tech_DB;


--CONSULTA 1 - VISTA BASE DEL PROYECTO--

SELECT
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS cliente,
    c.ciudad,
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM ventas v
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos p
    ON v.id_producto = p.id_producto
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta;

--CONSULTA 2 - CLIENTES SIN VENTAS--

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

--CONSULTA 3 - PRODUCTOS SIN VENTAS--

SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
LEFT JOIN ventas v
    ON p.id_producto = v.id_producto
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria
WHERE v.id_venta IS NULL;


--CONSULTA 4 - CONSOLIDADO POR PERIODO--

SELECT
    canal,
    SUM(total) AS total_facturado
FROM
(
    SELECT
        fecha_venta AS fecha,
        cantidad * precio_unitario AS total,
        '05 al 10 de marzo' AS canal
    FROM ventas
    WHERE fecha_venta <= '2024-03-10'

    UNION ALL

    SELECT
        fecha_venta AS fecha,
        cantidad * precio_unitario AS total,
        '11 al 15 de marzo' AS canal
    FROM ventas
    WHERE fecha_venta >= '2024-03-11'
) AS ventas_consolidadas

GROUP BY canal
ORDER BY canal;