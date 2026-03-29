/**
 * CONFIGURACIÓN CENTRAL DEL PROYECTO GÉNESIS
 * Este archivo centraliza la identidad de la farmacia para facilitar el escalado (SaaS).
 */

const PharmacyConfig = {
    // Identidad de Marca
    name: "López Asiain Castaño",
    slogan: "Tu Salud, Nuestra Prioridad",
    logoText: "López Asiain",
    highlightText: "Castaño",

    // Contacto y Ubicación
    phone: "+34 918 90 10 54",
    email: "info@farmacialopezasiain.com",
    address: "Calle Juliana, 4, 28280 El Escorial, Madrid",

    // Configuración de Sistema
    tenantId: "8a4fde12-5b6c-4e8d-9f0a-1b2c3d4e5f6g", // ID único de esta farmacia
    currency: "€",

    // Estética Dinámica (Variables CSS)
    colors: {
        primary: "#0a5c4a",
        primaryLight: "#12826a",
        accent: "#2ecc71",
        background: "#f4f7f6"
    }
};

// Exportar para uso en frontend (compatibilidad con scripts clásicos)
if (typeof module !== 'undefined' && module.exports) {
    module.exports = PharmacyConfig;
} else {
    window.PharmacyConfig = PharmacyConfig;
}
