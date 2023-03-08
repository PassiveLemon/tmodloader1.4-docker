FROM alpine:latest

RUN apk update && apk upgrade &&\
    apk add bash grep curl unzip icu-dev &&\
    mkdir -p /tmodloader/server/ &&\
    mkdir -p /tmodloader/config/ModPacks &&\
    mkdir -p /tmodloader/config/Worlds

COPY entrypoint.sh /tmodloader/

RUN chmod +x /tmodloader/entrypoint.sh

ENV VERSION="latest"

EXPOSE 7777

ENTRYPOINT ["/tmodloader/entrypoint.sh"]