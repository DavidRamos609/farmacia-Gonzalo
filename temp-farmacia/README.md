# Entorno de Pruebas Piloto - Farmacia López Asiain

Este directorio contiene una versión personalizada y aislada del Proyecto Génesis para la **Farmacia López Asiain Castaño** (El Escorial).

## Propósito
- **PoC (Proof of Concept)**: Demostrar el valor del sistema en un entorno real antes de la integración total.
- **Personalización**: Contiene configuraciones específicas (teléfono, dirección, datos de stock) que difieren del núcleo SaaS genérico.
- **Seguridad**: Permite realizar pruebas de voz e integración de datos sin afectar la estructura principal del software.

## Estructura
- `frontend/`: Versión personalizada de la interfaz con datos reales de la farmacia.
- `database_schema.sql`: Esquema de base de datos específico para el piloto (incluye datos de prueba).
- `iniciar_pilot.sh`: Script para desplegar este entorno de forma rápida.

---
*Nota: Para cambios en la lógica base del producto, editar la carpeta `/frontend` en la raíz del proyecto.*

## Desarrollo Local

```bash
# Construir imagen docker local
docker build -t farmacia .

# Desplegar localmente
docker run -d -p 8080:80 farmacia
```

## Consideraciones Coolify

- **Build Pack:** Dockerfile
- **Puerto:** 80
- **Dockerfile Location:** `./Dockerfile`
- **Health Check:** `HTTP GET localhost:80/health/` (Interval: 30s, Timeout: 10s, Start Period: 10s, Retries: 3)
- **Variables Requeridas:** Ver `.env.example` si aplica.

