# Dockerfile optimizado para producción - Farmacia López Asiain
FROM nginx:alpine

# Instalar curl para el healthcheck
RUN apk add --no-cache curl

# Configurar Nginx para escuchar en puerto 8000
RUN sed -i 's/listen \(.*\)80;/listen 8000;/' /etc/nginx/conf.d/default.conf

# Copiar la aplicación al servidor Nginx
COPY . /usr/share/nginx/html/

# Exponer el puerto público 8000
EXPOSE 8000

# Health check con curl y start-period de 60s
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:8000/health/ || exit 1
