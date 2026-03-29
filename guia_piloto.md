# Guía de Pruebas Piloto (Sandbox)

Esta carpeta contiene todo lo necesario para que pruebes el sistema intensivamente durante 10-12 días antes del lanzamiento oficial.

## 🧪 ¿Qué puedes probar en este Sandbox?

1.  **Sincronización de Stock**: Ejecuta `node simulate_stock.js`. Verás como los medicamentos en `mock_medications.json` cambian su stock aleatoriamente.
2.  **Escenarios de Crisis**: El script disparará automáticamente una "crisis de stock" cada 30 segundos (ej: agotando el Ventolin o la Amoxicilina). 
    - **Objetivo**: Observar la alerta roja en el Dashboard y cómo la IA responde "Sin stock" a las llamadas durante ese periodo.
3.  **Identidad de Prueba**: Puedes registrar a tu familia como "Pacientes de Prueba" en el portal usando números de Tarjeta Sanitaria ficticios.
4.  **Llamadas a la IA**: Usa el número de Vapi para preguntar por los medicamentos que están en `mock_medications.json` (ej. "¿Tenéis stock de Ventolin?").

## 📂 Archivos de Prueba
- `mock_medications.json`: Tu inventario ficticio de +50 productos.
- `simulate_stock.js`: El motor que genera "movimiento" en la farmacia.

## 📝 Notas de Seguridad
- Los datos de esta carpeta no afectan a la base de datos de producción real del cliente.
- Siéntete libre de "romperlo" todo; este es tu entorno de aprendizaje.

---
*Club Génesis - Modo Pilot - 2026*
