-- Datos de Prueba: Farmacia López Asiain Castaño
-- Entorno: Local / Testing

-- Limpiar datos existentes (Opcional)
-- TRUNCATE pacientes, productos, formulas_magistrales RESTART IDENTITY CASCADE;

-- 1. Insertar Pacientes
INSERT INTO pacientes (nombre_completo, telefono, email, puntos_fidelidad, historial_cronico)
VALUES 
('María García López', '+34600111222', 'maria.garcia@email.com', 150, ARRAY['Atorvastatina', 'Omeprazol']),
('Juan Rodríguez Pérez', '+34600333444', 'juan.rod@email.com', 45, ARRAY['Metformina']),
('Carmen Martínez Soler', '+34611555666', 'carmen.ms@email.com', 210, ARRAY['Levotiroxina']);

-- 2. Insertar Productos (Parafarmacia y Stock)
INSERT INTO productos (codigo_nacional, nombre, categoria, precio_euro, stock, descripcion)
VALUES 
('123456', 'Paracetamol 1g 40 comprimidos', 'medicamento', 2.50, 100, 'Analgésico y antipirético.'),
('234567', 'Crema Hidratante Facial UV50', 'parafarmacia', 18.95, 20, 'Protección solar alta con ácido hialurónico.'),
('345678', 'Suero Fisiológico 30 monodosis', 'parafarmacia', 5.30, 50, 'Limpieza nasal y ocular.'),
('456789', 'Amoxicilina 500mg (Bajo receta)', 'medicamento', 4.15, 15, 'Antibiótico de amplio espectro.');

-- 3. Insertar Fórmulas Magistrales
INSERT INTO formulas_magistrales (nombre_formula, composicion, indicaciones, paciente_id, estado)
VALUES 
('Crema Dermatológica Personalizada MGL', '{"urea": "5%", "acido_retinoico": "0.05%"}', 'Aplicar una vez al día por la noche.', (SELECT id FROM pacientes WHERE nombre_completo = 'María García López'), 'en_preparacion'),
('Jarabe Pediátrico Sin Azúcar', '{"paracetamol": "100mg/ml"}', 'Dosis según peso del niño.', (SELECT id FROM pacientes WHERE nombre_completo = 'Juan Rodríguez Pérez'), 'validada');
