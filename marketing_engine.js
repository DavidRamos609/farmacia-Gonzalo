/**
 * GENERADOR DE MAILING Y AUTOMATIZACIONES GÉNESIS
 */

const MarketingEngine = {
    // Simulación de envío de correo electrónico
    sendEmail: (to, type, data) => {
        console.info(`[SIMULADOR-MAILCHIMP]: Enviando email de tipo "${type}" a ${to}`);

        const templates = {
            welcome: `Bienvenido al Club Génesis, ${data.name}. Tienes 500 puntos de regalo.`,
            birthday: `¡Feliz cumpleaños, ${data.name}! Tu crema UV50 te espera en la farmacia.`,
            pickup_ready: `Hola ${data.name}, tu medicación de la Tarjeta Sanitaria está lista para recoger.`
        };

        return new Promise((resolve) => {
            setTimeout(() => {
                console.log(`Correo electrónico enviado con éxito: "${templates[type]}"`);
                resolve(true);
            }, 1000);
        });
    },

    // Orquestador de eventos de fidelización
    triggerEvent: (patientId, eventName) => {
        const mockDb = {
            "001": { name: "María García", email: "maria@example.com" }
        };

        const patient = mockDb[patientId];
        if (patient) {
            MarketingEngine.sendEmail(patient.email, eventName, { name: patient.name });
            MarketingEngine.trackConversion(eventName);
        }
    },

    // Tracking de conversiones para el Dashboard
    trackConversion: (campaign) => {
        let stats = JSON.parse(localStorage.getItem('marketing_stats') || '{"total_impact": 0, "conversions": 0, "history": []}');
        stats.total_impact += 12.5; // Valor medio por conversión
        stats.conversions += 1;
        stats.history.push({ time: new Date().toISOString(), campaign });
        localStorage.setItem('marketing_stats', JSON.stringify(stats));
        console.log(`[MARKETING]: Conversión registrada para ${campaign}.`);
    },

    getStats: () => {
        return JSON.parse(localStorage.getItem('marketing_stats') || '{"total_impact": 0, "conversions": 0, "history": []}');
    }
};

if (typeof module !== 'undefined' && module.exports) {
    module.exports = MarketingEngine;
} else {
    window.MarketingEngine = MarketingEngine;
}
