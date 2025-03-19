# Usamos la imagen base nginxdemos/hello:latest
FROM nginxdemos/hello:latest

# Creamos un script para generar contenido dinámico con las variables de ambiente
RUN echo '#!/bin/sh' > /docker-entrypoint.d/40-add-env-info.sh && \
    echo 'echo "<h3>Environment: $ENVIRONMENT</h3>" >> /usr/share/nginx/html/index.html' >> /docker-entrypoint.d/40-add-env-info.sh && \
    echo 'echo "<h3>Secret: $SECRET_VALUE</h3>" >> /usr/share/nginx/html/index.html' >> /docker-entrypoint.d/40-add-env-info.sh && \
    chmod +x /docker-entrypoint.d/40-add-env-info.sh

# Exponemos el puerto por defecto de Nginx
EXPOSE 80

# La imagen nginxdemos/hello ya tiene un ENTRYPOINT definido, por lo que no es necesario especificarlo