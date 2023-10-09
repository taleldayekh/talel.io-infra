FROM nginx:1.25.2-alpine

# Pass path to scripts as build args so this
# Dockerfile finds them in its build context.
ARG PATH_TO_ENTRYPOINT_SCRIPT
ARG PATH_TO_NGINX_CONF

COPY ${PATH_TO_ENTRYPOINT_SCRIPT} /usr/local/bin/
COPY ${PATH_TO_NGINX_CONF} /etc/nginx/conf.d/

RUN apk add --no-cache certbot-nginx
RUN apk add --no-cache busybox

# Create cron job for hourly SSL renewal checks
RUN echo '0 * * * * /usr/bin/certbot renew -n' > /etc/crontabs/root

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
