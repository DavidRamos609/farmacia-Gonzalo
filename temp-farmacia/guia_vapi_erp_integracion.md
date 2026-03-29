# Guía Técnica: Vapi & Integración con ERP Farmacéutico

Esta guía explica cómo poner en marcha el Agente de Voz (Génesis-Voice) y cómo conectar la base de datos local de la farmacia con nuestra plataforma.

## 🎙️ 1. Configuración de Vapi (Génesis-Voice)
Vapi es el "director de orquesta" de la voz. Tú no necesitas programarlo, solo importar la configuración que he preparado.

### Pasos para la Demo:
1.  **Crea una cuenta** en [Vapi.ai](https://vapi.ai).
2.  **Crea un nuevo Asistente**: Selecciona "Blank Assistant".
3.  **Importa la Configuración**: Usa el contenido de `genesis_voice_vapi_config.json`.
    - Copia el bloque de `tools` y pégalo en la sección de "Tools".
    - Copia el `systemPrompt` en la sección de "Transcriber/Model".
4.  **Configura el Número**: Vapi te dará un número de teléfono de prueba. Al llamar a ese número, estarás hablando directamente con Génesis IA.

---

## 🔗 2. Sincronización con el ERP de la Farmacia
Para que la IA sepa el stock real (Nixfarma, Farmatic, etc.), necesitamos un "puente".

### Opción A: Sincronización por Webhook (Recomendado para PoC)
1.  **Exportación**: El programa de la farmacia exporta un archivo (CSV/JSON) de stock cada 15-30 minutos.
2.  **Puente**: Un pequeño script carga esos datos en nuestra base de datos PostgreSQL/Supabase.
3.  **Resultado**: Cuando el cliente pregunta por voz, la IA consulta nuestra base de datos, que está sincronizada con la de la farmacia.

### Opción B: Conexión Directa (SaaS Escalable)
- Creamos una API intermedia que consulta directamente la base de datos del ERP (SQL Server/Oracle) de la farmacia y devuelve el dato a Vapi en tiempo real.

---

## 📱 3. Presentación al Farmacéutico (Paso a Paso)

### El "Efecto Magia"
1.  **Pre-Carga**: Asegúrate de que hemos subido algunos productos reales de su farmacia a nuestra tabla `productos` con sus precios en €.
2.  **La Llamada**: Pídele al farmacéutico que llame al número de Vapi desde su móvil.
3.  **Guion**: 
    - *"Hola, ¿tenéis stock de Ibuprofeno 600?"*
    - IA: *"Sí, disponemos de 10 unidades. El precio es de 2,50€ la caja. ¿Quieres que te reserve una?"*
4.  **Confirmación Visual**: Abre el **Dashboard del Farmacéutico** en el portátil y muéstrale cómo la consulta ha quedado registrada.

---

## 💰 4. El Valor del Cierre
Dile esto: *"No solo estás comprando una web o un bot. Estás comprando una infraestructura que libera a tus técnicos de llamadas repetitivas y que avisa a tus pacientes por su Tarjeta Sanitaria. Es una farmacia inteligente, no solo digitalizada"*.
