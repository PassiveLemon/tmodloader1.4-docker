FROM alpine:latest

RUN apk update && apk upgrade &&\
    apk add grep curl bash unzip icu-dev &&\
    mkdir -p /tmodloader/server/ &&\
    mkdir -p /tmodloader/config/ModPacks &&\
    mkdir -p /tmodloader/config/Worlds

COPY entrypoint.sh /tmodloader/

RUN chmod +x /tmodloader/entrypoint.sh

ENV VERSION=""

EXPOSE 7777

ENTRYPOINT ["/tmodloader/entrypoint.sh"]