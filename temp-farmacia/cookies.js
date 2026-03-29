/**
 * Sistema de Gestión de Cookies - Farmacia López-Asiain
 * Cumplimiento RGPD/LOPDGDD
 */

(function () {
    const COOKIE_NAME = 'farmacia_cookies_accepted';

    function createBanner() {
        if (localStorage.getItem(COOKIE_NAME)) return;

        const banner = document.createElement('div');
        banner.id = 'cookie-consent-banner';
        banner.style.cssText = `
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            background: #ffffff;
            padding: 20px;
            box-shadow: 0 -5px 25px rgba(0,0,0,0.1);
            z-index: 100000;
            display: flex;
            flex-direction: column;
            align-items: center;
            border-top: 3px solid var(--primary, #2ecc71);
            font-family: inherit;
        `;

        banner.innerHTML = `
            <div style="max-width: 1000px; width: 100%; display: flex; flex-direction: column; gap: 15px;">
                <div style="font-size: 0.95rem; line-height: 1.6; color: #333;">
                    <strong>Tu privacidad es nuestra prioridad.</strong> Utilizamos cookies propias y de terceros para 
                    mejorar tu experiencia, analizar el tráfico y personalizar el contenido. 
                    Puedes consultar más información en nuestra 
                    <a href="/POLITICA_COOKIES.md" target="_blank" style="color: var(--primary); font-weight: 600;">Política de Cookies</a>.
                </div>
                <div style="display: flex; gap: 10px; justify-content: flex-end;">
                    <button id="cookie-reject" style="padding: 10px 20px; border: 1px solid #ddd; background: #fff; border-radius: 8px; cursor: pointer; font-weight: 500;">Rechazar</button>
                    <button id="cookie-accept" style="padding: 10px 20px; border: none; background: var(--primary, #2ecc71); color: #fff; border-radius: 8px; cursor: pointer; font-weight: 600;">Aceptar todas</button>
                </div>
            </div>
        `;

        document.body.appendChild(banner);

        document.getElementById('cookie-accept').addEventListener('click', () => {
            localStorage.setItem(COOKIE_NAME, 'true');
            banner.remove();
        });

        document.getElementById('cookie-reject').addEventListener('click', () => {
            localStorage.setItem(COOKIE_NAME, 'false');
            banner.remove();
        });
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', createBanner);
    } else {
        createBanner();
    }
})();
