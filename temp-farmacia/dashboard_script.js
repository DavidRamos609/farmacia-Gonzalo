document.addEventListener('DOMContentLoaded', () => {
    console.log('Dashboard López Asiain inicializado.');

    const tableBodyRefill = document.querySelector('#pedidos tbody');
    const kpiStockBajo = document.querySelector('.kpi-card:nth-child(3) .value');

    // Función para cargar los datos de stock
    async function loadStock() {
        try {
            // En un entorno real esto sería una API, aquí leemos el JSON directamente
            // Nota: Para que funcione vía file:// o server local, el path debe ser accesible.
            // Dado que estamos en pruebas_piloto/frontend/, el path relativo a mock_medications.json es ../mock_medications.json
            const response = await fetch('../mock_medications.json');
            const data = await response.json();
            updateDashboard(data);
        } catch (error) {
            console.error('Error cargando stock:', error);
        }
    }

    // Función para actualizar el dashboard con los datos reales
    function updateDashboard(medications) {
        let lowStockItems = medications.filter(m => m.stock <= m.stock_minimo);

        // Actualizar KPI de Stock Bajo
        if (kpiStockBajo) {
            kpiStockBajo.textContent = lowStockItems.length;
        }

        // Limpiar tabla de pedidos automáticos
        if (tableBodyRefill) {
            tableBodyRefill.innerHTML = '';

            lowStockItems.forEach(item => {
                const qtyToOrder = item.stock_maximo - item.stock;
                const totalEst = (qtyToOrder * item.precio_euro).toFixed(2);

                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td>${item.nombre}</td>
                    <td>${qtyToOrder} uds.</td>
                    <td><span style="background: #fff3cd; color: #856404; padding: 4px 8px; border-radius: 4px; font-size: 0.75rem;">PENDIENTE</span></td>
                    <td>${totalEst} €</td>
                    <td><button class="btn-approve" data-id="${item.id}" style="padding: 5px 10px; border-radius: 6px; border: none; background: var(--primary); color: white; cursor: pointer;">Aprobar</button></td>
                `;
                tableBodyRefill.appendChild(tr);
            });

            // Añadir eventos a los botones de aprobar
            document.querySelectorAll('.btn-approve').forEach(btn => {
                btn.addEventListener('click', (e) => {
                    const id = e.target.getAttribute('data-id');
                    approveOrder(id);
                });
            });
        }
    }

    // Función para simular aprobación de pedido
    function approveOrder(id) {
        console.log(`Pedido aprobado para el producto ID: ${id}`);
        alert(`Pedido aprobado. Se ha enviado la orden de reposición al distribuidor.`);
        // Disparar evento de marketing (simulación: aviso al paciente)
        if (window.MarketingEngine) {
            window.MarketingEngine.triggerEvent('001', 'pickup_ready');
        }
        loadStock();
        updateMarketingUI();
    }

    // Función para actualizar la UI de marketing
    function updateMarketingUI() {
        if (window.MarketingEngine) {
            const stats = window.MarketingEngine.getStats();
            const impactCount = document.getElementById('marketing-impact-count');
            const impactEuros = document.getElementById('marketing-impact-euros');

            if (impactCount) impactCount.textContent = stats.conversions;
            if (impactEuros) impactEuros.textContent = `+${stats.total_impact.toFixed(0)}€`;
        }
    }

    // Función para cargar logs de voz
    async function loadVoiceLogs() {
        try {
            const response = await fetch('../voice_calls.json');
            const logs = await response.json();
            const kpiVoice = document.querySelector('.kpi-card:nth-child(4) .value');
            if (kpiVoice) kpiVoice.textContent = logs.length;
            console.log(`[GÉNESIS-VOICE]: ${logs.length} llamadas sincronizadas.`);
        } catch (e) { }
    }

    // Carga inicial y polling cada 10 segundos
    loadStock();
    updateMarketingUI();
    loadVoiceLogs();
    setInterval(() => {
        loadStock();
        updateMarketingUI();
        loadVoiceLogs();
    }, 10000);

    // Simulación de interactividad: Efectos hover originales
    const tableBody = document.getElementById('table-body');
    const rows = document.querySelectorAll('tr');
    rows.forEach(row => {
        row.style.transition = 'background-color 0.2s ease';
        row.addEventListener('mouseover', () => {
            if (row.parentElement.tagName === 'TBODY') {
                row.style.backgroundColor = '#f4f7f6';
            }
        });
        row.addEventListener('mouseout', () => {
            row.style.backgroundColor = 'transparent';
        });
    });

    // Mock: Notificación de nueva consulta de voz
    setTimeout(() => {
        console.info('IA: Nueva consulta recibida por Génesis-Voice - Paciente ID: 001');
    }, 5000);
});
