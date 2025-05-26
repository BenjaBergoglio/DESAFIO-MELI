-- Usuarios que cumplen años hoy y vendieron más de $1500 en enero 2020

SELECT c.customer_id, c.nombre, c.apellido
FROM Customer c
JOIN Item i ON i.seller_id = c.customer_id
JOIN Orders o ON o.item_id = i.item_id
WHERE MONTH(c.fecha_nacimiento) = MONTH(GETDATE())
  AND DAY(c.fecha_nacimiento) = DAY(GETDATE())
  AND o.fecha BETWEEN '2020-01-01' AND '2020-01-31'
GROUP BY c.customer_id, c.nombre, c.apellido
HAVING SUM(o.cantidad * o.precio_unitario) > 1500;


-- Top 5 vendedores por mes en 2020 (Categoría Celulares)

SELECT *
FROM (
    SELECT
        MONTH(o.fecha) AS mes_anio,
        YEAR(o.fecha) AS anio,
        c.nombre,
        c.apellido,
        COUNT(DISTINCT o.order_id) AS cantidad_ventas,
        SUM(o.cantidad) AS cantidad_productos,
        SUM(o.cantidad * o.precio_unitario) AS monto_total,
        ROW_NUMBER() OVER (
            PARTITION BY MONTH(o.fecha)
            ORDER BY SUM(o.cantidad * o.precio_unitario) DESC
        ) AS posicion
    FROM Orders o
    JOIN Item i ON o.item_id = i.item_id
    JOIN Category cat ON i.category_id = cat.category_id
    JOIN Customer c ON o.seller_id = c.customer_id
    WHERE cat.nombre = 'Celulares y Smartphones'
      AND o.fecha BETWEEN '2020-01-01' AND '2020-12-31'
    GROUP BY YEAR(o.fecha), MONTH(o.fecha), c.nombre, c.apellido
) sub
WHERE posicion <= 5
ORDER BY anio, mes_anio, posicion;



--Poblar tabla Item_Estado_Historico con SP reprocesable

CREATE PROCEDURE poblar_estado_items
    @p_fecha DATE
AS
BEGIN
    -- Eliminar datos existentes de esa fecha para que sea reprocesable
    DELETE FROM Item_Estado_Historico
    WHERE fecha_registro = @p_fecha;

    -- Insertar estado actual de los ítems
    INSERT INTO Item_Estado_Historico (fecha_registro, item_id, precio, estado)
    SELECT
        @p_fecha,
        item_id,
        precio,
        estado
    FROM Item;
END;

--Ejecutar

EXEC poblar_estado_items @p_fecha = CAST(GETDATE() AS DATE);
