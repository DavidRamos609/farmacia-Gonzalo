/**
 * SIMULADOR DE STOCK - PROYECTO GÉNESIS
 * Ejecuta este script para ver cambios en el Dashboard.
 */

const fs = require('fs');
const path = require('path');

const mockPath = path.join(__dirname, 'mock_medications.json');

function simulate() {
    let rawData = fs.readFileSync(mockPath);
    let medications = JSON.parse(rawData);

    // 1. Simular una venta aleatoria
    const randomIndex = Math.floor(Math.random() * medications.length);
    const item = medications[randomIndex];

    if (item.stock > 0) {
        item.stock -= 1;
        console.log(`[VENTA]: Se ha vendido 1 unidad de ${item.nombre}. Nuevo stock: ${item.stock}`);
    }

    // 2. Simular reposición si el stock es crítico
    medications.forEach(m => {
        if (m.stock < 10) {
            m.stock += 20;
            console.log(`[REPOSICIÓN]: Se han añadido 20 unidades de ${m.nombre} (Stock era crítico)`);
        }
    });

    // Guardar cambios
    fs.writeFileSync(mockPath, JSON.stringify(medications, null, 2));
}

// 3. MODO CRISIS (Depleción crítica de stock)
function triggerCrisis() {
    let rawData = fs.readFileSync(mockPath);
    let medications = JSON.parse(rawData);

    const criticalItems = ["Amoxicilina 500mg", "Metformina 850mg", "Ventolin Inhalador"];
    const chosenItem = criticalItems[Math.floor(Math.random() * criticalItems.length)];

    console.log(`\n⚠️  [ALERTA DE CRISIS]: El producto ${chosenItem} se ha agotado repentinamente.`);

    medications.forEach(m => {
        if (m.nombre === chosenItem) m.stock = 0;
    });

    fs.writeFileSync(mockPath, JSON.stringify(medications, null, 2));
}

// Ejecutar simulación normal cada 5 segundos
console.log("Iniciando simulación de stock con MODO CRISIS habilitado...");
setInterval(simulate, 5000);

// Disparar una crisis aleatoria cada 30 segundos para probar alertas
setInterval(triggerCrisis, 30000);
