# Estimación de Costes: Fase Pilot y Vapi

El despliegue de la Fase Pilot (10-15 días) tiene un coste operativo extremadamente bajo, ideal para demostrar eficiencia sin inversión inicial pesada.

## 1. Vapi (IA por Voz)
- **Capa Gratuita**: Vapi ofrece créditos iniciales gratuitos ($10 o minutos de prueba) que suelen cubrir de sobra una demo profesional y las primeras pruebas familiares.
- **Coste por Minuto (Post-Demo)**: ~0.15€ a 0.25€ por minuto (incluyendo transcripción, LLM y síntesis de voz premium).
  - *Estimación Pilot*: 100 minutos de pruebas intensas = ~20€.

## 2. Infraestructura (Supabase/PostgreSQL)
- **Capa Gratuita**: El esquema multi-tenant de este proyecto cabe perfectamente en el plan gratuito de Supabase (500MB de DB), suficiente para miles de registros de pacientes de prueba.
- **Coste**: 0€.

## 3. Telefonía (Twilio/Vonage)
- **Número de Teléfono**: ~1€ a 2€ al mes por un número local (+34).
- **Tráfico**: Vapi gestiona la mayoría de la conexión, Twilio solo cobra la terminación (~0.01€/min).
  - *Estimación Pilot*: ~2€ total.

## 4. Mailing (Resend/SendGrid)
- **Capa Gratuita**: Hasta 3.000 emails/mes gratis.
- **Coste**: 0€.

---

### TOTAL ESTIMADO TEST PILOTO (15 días)
**Inversión Inicial: ~25€**

Este pequeño coste permite presentarle al farmacéutico un sistema funcionando con **números reales y tecnología de nivel Google/OpenAI**. Una vez aprobado el proyecto, estos costes se repercuten en la cuota de suscripción del cliente.

*SaaS Factory - Análisis de Costes - 2026*
