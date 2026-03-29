-- Lógica de Pedidos Automáticos (Auto-Refill)

-- Función para comprobar stock y generar pedidos si es necesario
CREATE OR REPLACE FUNCTION check_and_generate_orders()
RETURNS VOID AS $$
DECLARE
    r_producto RECORD;
    v_tenant_id UUID;
BEGIN
    -- Recorrer productos que están por debajo del mínimo y no tienen pedidos pendientes
    FOR r_producto IN 
        SELECT p.id, p.tenant_id, p.nombre, p.stock_actual, p.stock_minimo, p.stock_maximo, p.precio_euro
        FROM productos p
        WHERE p.stock_actual <= p.stock_minimo
          AND NOT EXISTS (
              SELECT 1 FROM pedidos_proveedores pp 
              WHERE pp.producto_id = p.id 
                AND pp.estado = 'PENDIENTE'
          )
    LOOP
        -- Generar pedido para llegar al stock máximo
        INSERT INTO pedidos_proveedores (tenant_id, producto_id, cantidad, total_estimado_euro)
        VALUES (
            r_producto.tenant_id, 
            r_producto.id, 
            (r_producto.stock_maximo - r_producto.stock_actual),
            (r_producto.stock_maximo - r_producto.stock_actual) * r_producto.precio_euro * 0.7 -- Estimado (coste 70% PVP)
        );
        
        RAISE NOTICE 'Pedido automático generado para: %', r_producto.nombre;
    END LOOP;
END;
$$ LANGUAGE plpgsql;
