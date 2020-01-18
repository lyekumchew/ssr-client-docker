FROM alpine:latest

LABEL maintainer="AUTUMN"

#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --no-cache --update --virtual .build-env git \
    && cd /etc \
    && git clone -b manyuser https://github.com/lyekumchew/shadowsocksr.git \
    && apk del -f .build-env

RUN apk add --no-cache python3 libsodium \
    && rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

WORKDIR /etc/shadowsocksr/shadowsocks

ENTRYPOINT [ "/usr/bin/python3", "local.py", "-c", "config.json" ]

