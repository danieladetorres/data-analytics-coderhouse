---ACTIVIDAD NUMERO 4--
--ESTUDIANTE: DANIELA DE TORRES--
--VENTAS _TECH_DB---

--USAMOS LA BASE DE DATOS CREADA--
USE Ventas_Tech_DB;

-- =====================================================
-- CONSULTA 1 - RESUMEN EJECUTIVO MENSUAL
-- =====================================================

SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- =====================================================
-- CONSULTA 2 - RANKING DE PRODUCTOS
-- =====================================================

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

-- =====================================================
-- CONSULTA 3 - CLIENTES RECURRENTES
-- =====================================================

SELECT
    id_cliente,
    COUNT(*) AS cantidad_compras,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

-- =====================================================
-- CONSULTA 4 - ESTADISTICAS DE PRECIOS
-- =====================================================

SELECT
    MIN(precio_unitario) AS precio_minimo,
    MAX(precio_unitario) AS precio_maximo,
    CAST(AVG(precio_unitario) AS DECIMAL(10,2)) AS precio_promedio
FROM ventas;

-- =====================================================
-- HALLAZGOS DE NEGOCIO
-- =====================================================

-- HALLAZGO 1:
-- Durante marzo se registraron 10 pedidos, con una facturación
-- total de $6.444 y un ticket promedio de $644,40.

-- HALLAZGO 2:
-- El producto con ID 1 fue el que generó mayor facturación,
-- alcanzando $3.600 con 3 unidades vendidas.
-- En cambio, el producto con ID 2 fue el de mayor cantidad
-- de unidades vendidas (13), pero generó una facturación de $364.
-- Esto demuestra que un mayor volumen de unidades vendidas
-- no necesariamente implica una mayor facturación.

-- HALLAZGO 3:
-- Los precios unitarios de las ventas presentan una amplitud importante:
-- el precio mínimo fue de $28, el máximo de $1.200
-- y el precio promedio fue de $382,10.