FROM nginx:alpine

# Copiar la aplicación al servidor Nginx
COPY . /usr/share/nginx/html/

# Exponer el puerto público
EXPOSE 80

# Health check con wget (ya instalado en alpine)
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost/health/ || exit 1
