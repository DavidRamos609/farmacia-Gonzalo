-- Funciones SQL para la Integración del Agente de Voz IA (Genesis-Voice)

-- 1. Función para establecer el contexto de la farmacia (Tenant ID)
-- Esto permite que el sistema sepa qué farmacia está operando actualmente.
CREATE OR REPLACE FUNCTION set_current_pharmacy(p_tenant_id UUID)
RETURNS VOID AS $$
BEGIN
    PERFORM set_config('app.current_tenant', p_tenant_id::TEXT, false);
END;
$$ LANGUAGE plpgsql;

-- 2. Función para obtener el stock filtrado por farmacia
CREATE OR REPLACE FUNCTION get_product_stock(nombre_busqueda TEXT)
RETURNS TABLE (nombre TEXT, stock INTEGER, precio_euro DECIMAL(10,2)) AS $$
BEGIN
    RETURN QUERY 
    SELECT p.nombre, p.stock, p.precio_euro 
    FROM productos p 
    WHERE p.nombre ILIKE '%' || nombre_busqueda || '%'
    LIMIT 1;
END;
$$ LANGUAGE plpgsql;

-- 2. Función para obtener info del paciente por teléfono
CREATE OR REPLACE FUNCTION get_patient_info_by_phone(tel_busqueda TEXT)
RETURNS TABLE (id UUID, nombre_completo TEXT, puntos_fidelidad INTEGER) AS $$
BEGIN
    RETURN QUERY 
    SELECT p.id, p.nombre_completo, p.puntos_fidelidad
    FROM pacientes p 
    WHERE p.telefono = tel_busqueda;
END;
$$ LANGUAGE plpgsql;

-- 3. Función para consultar el estado de la fórmula magistral más reciente
CREATE OR REPLACE FUNCTION get_latest_formula_status(p_id UUID)
RETURNS TABLE (nombre_formula TEXT, estado TEXT, fecha_preparacion TIMESTAMP WITH TIME ZONE) AS $$
BEGIN
    RETURN QUERY 
    SELECT f.nombre_formula, f.estado, f.fecha_preparacion
    FROM formulas_magistrales f
    WHERE f.paciente_id = p_id
-- 4. Función para agendar una cita
CREATE OR REPLACE FUNCTION book_appointment(p_id UUID, f_cita TIMESTAMP WITH TIME ZONE, v_motivo TEXT, v_canal TEXT)
RETURNS UUID AS $$
DECLARE
    new_cita_id UUID;
BEGIN
    INSERT INTO citas (paciente_id, fecha_cita, motivo, canal)
    VALUES (p_id, f_cita, v_motivo, v_canal)
    RETURNING id INTO new_cita_id;
    RETURN new_cita_id;
END;
$$ LANGUAGE plpgsql;

-- 5. Función para registrar una petición de medicación
CREATE OR REPLACE FUNCTION record_medication_request(p_id UUID, v_producto TEXT)
RETURNS VOID AS $$
BEGIN
    INSERT INTO pedidos (paciente_id, total_euro, estado, canal)
    VALUES (p_id, 0.00, 'pendiente_revision', 'voz_ia');
END;
$$ LANGUAGE plpgsql;
