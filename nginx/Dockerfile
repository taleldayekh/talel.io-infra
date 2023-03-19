FROM nginx:1.23.3-alpine

ADD talelio.conf /etc/nginx/conf.d/talelio.conf
ADD entrypoint.sh /

RUN apk add --no-cache certbot-nginx

ENTRYPOINT ["sh", "entrypoint.sh"]
