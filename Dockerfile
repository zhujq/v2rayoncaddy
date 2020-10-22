FROM alpine:latest

#ENV CONFIG_JSON=none CERT_PEM=none KEY_PEM=none 

#RUN apk add --no-cache --virtual .build-deps ca-certificates curl \
# && mkdir -m 777 /v2raybin \ 
# && cd /v2raybin \
# && curl -L -H "Cache-Con#trol: no-cache" -o v2ray.zip https://github.com/v2ray/v2ray-core/releases/download/v$VER/v2ray-linux-64.zip \
# && unzip v2ray.zip \
# && mv /v2raybin/v2ray-v$VER-linux-64/v2ray /v2raybin/ \
# && mv /v2raybin/v2ray-v$VER-linux-64/v2ctl /v2raybin/ \
# && mv /v2raybin/v2ray-v$VER-linux-64/geoip.dat /v2raybin/ \
# && mv /v2raybin/v2ray-v$VER-linux-64/geosite.dat /v2raybin/ \
# && chmod +x /v2raybin/v2ray \
# && rm -rf v2ray.zip \
# && rm -rf v2ray-v$VER-linux-64 \
# && chgrp -R 0 /v2raybin \
# && chmod -R g+rwX /v2raybin 

ADD config.json /config.json
ADD entrypoint.sh /entrypoint.sh
ADD caddy /caddy
ADD Caddyfile /Caddyfile
ADD static/ /static/

RUN mkdir -m 777 /v2ray && wget --no-check-certificate -O v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip \
	&& unzip v2ray.zip -d /v2ray && chmod +x /entrypoint.sh  && chmod +x /caddy

ENTRYPOINT  /entrypoint.sh 

EXPOSE 8080
