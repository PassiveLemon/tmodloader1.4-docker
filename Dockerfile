FROM alpine:latest

RUN apk update &&\
    apk upgrade &&\
    apk add curl bash unzip icu-dev &&\
    mkdir -p /server/ &&\
    mkdir -p /config/ModPacks &&\
    mkdir -p /config/Worlds

COPY entrypoint.sh /

ENV VERSION=""

EXPOSE 7777

WORKDIR /server/

ENTRYPOINT ["/entrypoint.sh"]