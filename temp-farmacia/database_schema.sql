-- Esquema de Base de Datos: Proyecto Génesis (Farmacia López Asiain Castaño)
-- Arquitectura: PostgreSQL con Row-Level Security (RLS)
-- Moneda: Euro (€)

-- 1. EXTENSIONES Y SEGURIDAD
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. TABLAS MAESTRAS

-- Tabla de Pacientes: Almacena información personal, fidelización y acceso a la app
CREATE TABLE IF NOT EXISTS pacientes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nombre_completo TEXT NOT NULL,
    telefono TEXT UNIQUE,
    email TEXT UNIQUE,
    password_hash TEXT, -- Para el portal del cliente
    fecha_nacimiento DATE,
    tarjeta_sanitaria_num TEXT UNIQUE, -- CUSE / Comunidad de Madrid
    puntos_fidelidad INTEGER DEFAULT 0,
    alergias TEXT[],
    historial_cronico TEXT[], -- Medicación de uso recurrente
    tenant_id UUID DEFAULT '00000000-0000-0000-0000-000000000000',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de Productos: Inventario de parafarmacia y medicamentos
-- Todos los precios están expresados en Euros (€)
CREATE TABLE IF NOT EXISTS productos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo_nacional TEXT UNIQUE,
    nombre TEXT NOT NULL,
    categoria TEXT, -- 'parafarmacia', 'medicamento', 'formula'
    precio_euro DECIMAL(10,2) NOT NULL, -- Precio de venta al público en €
    stock INTEGER DEFAULT 0,
    stock_minimo INTEGER DEFAULT 5,
    descripcion TEXT,
    imagen_url TEXT,
    beneficios_ia TEXT -- Contenido de marketing generado por IA
);

-- Tabla de Fórmulas Magistrales: Elaboraciones personalizadas en laboratorio
CREATE TABLE IF NOT EXISTS formulas_magistrales (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nombre_formula TEXT NOT NULL,
    composicion JSONB NOT NULL, -- Ingredientes y cantidades
    indicaciones TEXT,
    paciente_id UUID REFERENCES pacientes(id),
    medico_prescriptor TEXT,
    fecha_preparacion TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    estado TEXT DEFAULT 'pendiente', -- 'en_preparacion', 'validada', 'entregada'
    certificacion_digital UUID DEFAULT uuid_generate_v4()
);

-- Tabla de Pedidos: Historial de ventas y transacciones
-- Los totales y puntos están calculados en base a la moneda local (€)
CREATE TABLE IF NOT EXISTS pedidos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    paciente_id UUID REFERENCES pacientes(id),
    total_euro DECIMAL(10,2) NOT NULL, -- Importe total de la compra en €
    estado TEXT DEFAULT 'pendiente', -- 'pagado', 'en_reparto', 'completado'
    canal TEXT, -- 'web', 'app', 'whatsapp', 'voz_ia', 'mostrador'
    puntos_ganados INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de Citas (Calendario Gestionado por IA y Dashboard)
CREATE TABLE IF NOT EXISTS citas (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    paciente_id UUID REFERENCES pacientes(id),
    fecha_cita TIMESTAMP WITH TIME ZONE NOT NULL,
    motivo TEXT,
    estado TEXT DEFAULT 'programada', -- 'realizada', 'cancelada'
    canal TEXT, -- 'voz_ia', 'web', 'presencial'
    tenant_id UUID DEFAULT '00000000-0000-0000-0000-000000000000',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de Prescripciones Externas (Sincronizada con Tarjeta Sanitaria)
CREATE TABLE IF NOT EXISTS prescripciones_externas (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    paciente_id UUID REFERENCES pacientes(id),
    medicamento_nombre TEXT NOT NULL,
    descripcion TEXT,
    precio_euro DECIMAL(10,2) NOT NULL,
    stock_actual INTEGER DEFAULT 0,
    stock_minimo INTEGER DEFAULT 10,
    stock_maximo INTEGER DEFAULT 50,
    categoria TEXT,
    preparado_en_farmacia BOOLEAN DEFAULT FALSE,
    tenant_id UUID DEFAULT '00000000-0000-0000-0000-000000000000',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 10. Tabla de Pedidos a Proveedores (Auto-Refill)
CREATE TABLE pedidos_proveedores (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID REFERENCES farmacias(id),
    producto_id UUID REFERENCES productos(id),
    cantidad INTEGER NOT NULL,
    estado TEXT DEFAULT 'PENDIENTE', -- PENDIENTE, ENVIADO, RECIBIDO
    fecha_pedido TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    total_estimado_euro DECIMAL(10,2)
);

ALTER TABLE pedidos_proveedores ENABLE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_pedidos_prov ON pedidos_proveedores USING (tenant_id = auth.jwt() ->> 'tenant_id')::UUID);
    preparado_en_farmacia BOOLEAN DEFAULT FALSE,
    tenant_id UUID DEFAULT '00000000-0000-0000-0000-000000000000',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. SEGURIDAD DE NIVEL DE FILA (RLS)
ALTER TABLE pacientes ENABLE ROW LEVEL SECURITY;
ALTER TABLE productos ENABLE ROW LEVEL SECURITY;
ALTER TABLE formulas_magistrales ENABLE ROW LEVEL SECURITY;
ALTER TABLE pedidos ENABLE ROW LEVEL SECURITY;
ALTER TABLE citas ENABLE ROW LEVEL SECURITY;
ALTER TABLE prescripciones_externas ENABLE ROW LEVEL SECURITY;

-- Política de aislamiento
CREATE POLICY tenant_isolation_policy ON pacientes USING (tenant_id = current_setting('app.current_tenant', true)::UUID);
CREATE POLICY tenant_isolation_citas ON citas USING (tenant_id = current_setting('app.current_tenant', true)::UUID);
CREATE POLICY tenant_isolation_prescripciones ON prescripciones_externas USING (tenant_id = current_setting('app.current_tenant', true)::UUID);

-- 4. ÍNDICES PARA OPTIMIZACIÓN DE BÚSQUEDA
CREATE INDEX idx_pacientes_telefono ON pacientes(telefono);
CREATE INDEX idx_productos_categoria ON productos(categoria);
CREATE INDEX idx_formulas_paciente ON formulas_magistrales(paciente_id);
CREATE INDEX idx_pedidos_paciente ON pedidos(paciente_id);

