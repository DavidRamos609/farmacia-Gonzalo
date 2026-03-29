FROM nginx:alpine

# Copiar archivos HTML/JS/CSS al directorio de Nginx
COPY . /usr/share/nginx/html/

# Configurar Nginx para servir en puerto 8000
RUN echo 'server { \
    listen 8000; \
    server_name _; \
    root /usr/share/nginx/html; \
    index index.html; \
    location / { \
        try_files $uri $uri/ /index.html; \
    } \
    location /health { \
        return 200 "OK"; \
        add_header Content-Type text/plain; \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:8000/health || exit 1

CMD ["nginx", "-g", "daemon off;"]
