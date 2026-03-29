/**
 * SIMULADOR DE LLAMADAS GÉNESIS-VOICE
 * Simula la entrada de consultas telefónicas gestionadas por IA.
 */

const fs = require('fs');
const path = require('path');

const VOICE_LOG_PATH = path.join(__dirname, 'voice_calls.json');

const sampleCalls = [
    { patient: "María García", intent: "Consulta nutricional", transcript: "Hola, me gustaría agendar una cita para nutrición." },
    { patient: "Anónimo", intent: "Horario", transcript: "¿A qué hora cerráis hoy sábado?" },
    { patient: "Juan Pérez", intent: "Stock Medicamento", transcript: "Hola, ¿tenéis Ibuprofeno de 600mg en stock?" }
];

function triggerVoiceCall() {
    const call = sampleCalls[Math.floor(Math.random() * sampleCalls.length)];
    call.timestamp = new Date().toISOString();

    console.log(`\n📞 [GÉNESIS-VOICE]: Nueva llamada entrante...`);
    console.log(`👤 Paciente: ${call.patient}`);
    console.log(`🤖 Intención: ${call.intent}`);
    console.log(`📝 Transcripción: "${call.transcript}"`);

    // Guardar en log persistente para el Dashboard
    let logs = [];
    try {
        if (fs.existsSync(VOICE_LOG_PATH)) {
            logs = JSON.parse(fs.readFileSync(VOICE_LOG_PATH));
        }
    } catch (e) { }

    logs.unshift(call);
    fs.writeFileSync(VOICE_LOG_PATH, JSON.stringify(logs.slice(0, 10), null, 2));

    console.log(`✅ Llamada registrada en el sistema.`);
}

// Simular una llamada cada 45 segundos
console.log("Iniciando simulador de GÉNESIS-VOICE...");
setInterval(triggerVoiceCall, 45000);

// Disparar una inicial
triggerVoiceCall();
