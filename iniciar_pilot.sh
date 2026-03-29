#!/bin/bash

# SCRIPT DE INICIO - FASE PILOT GÉNESIS
# Ejecuta este script para preparar el entorno de pruebas.

echo "🚀 Iniciando Entorno de Pruebas Piloto - Farmacia López Asiain"
echo "------------------------------------------------------------"

# 1. Verificar dependencias
if ! command -v node &> /dev/null
then
    echo "❌ Error: Node.js no está instalado. Es necesario para ejecutar el simulador."
    exit
fi

# 2. Iniciar Simuladores en segundo plano
echo "📦 Iniciando Simulador de Stock (Modo Crisis Activo)..."
node ./simulate_stock.js &
STOCK_PID=$!

echo "📞 Iniciando Simulador de IA de Voz (Génesis-Voice)..."
node ./simulate_voice_interaction.js &
VOICE_PID=$!

echo "✅ Simuladores corriendo con PIDs: Stock($STOCK_PID), Voz($VOICE_PID)"
echo "------------------------------------------------------------"
echo "📂 Documentación de ayuda: ./guia_piloto.md"
echo "📊 Datos de stock: ./mock_medications.json"
echo "------------------------------------------------------------"
echo "Procede a configurar Vapi y el Portal siguiendo la Guía Pilot."
echo "Para detener la simulación, usa: kill $STOCK_PID $VOICE_PID"
echo "------------------------------------------------------------"
