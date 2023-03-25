FROM alpine:latest

RUN apk update && apk upgrade &&\
    apk add bash grep curl unzip icu-dev &&\
    mkdir -p /tmodloader/server/ &&\
    mkdir -p /tmodloader/config/ModPacks &&\
    mkdir -p /tmodloader/config/Worlds

COPY entrypoint.sh /tmodloader/

RUN chmod +x /tmodloader/entrypoint.sh

ENV VERSION="latest"
ENV SERVERCONFIG="0"

ENV AUTOCREATE="2"
ENV DIFFICULTY="0"
ENV BANLIST="banlist.txt"
ENV LANGUAGE="en-US"
ENV MAXPLAYERS="8"
ENV MODPACK=""
ENV MOTD=""
ENV NPCSTREAM="15"
ENV PASSWORD=""
ENV PORT="7777"
ENV PRIORITY="1"
ENV SECURE="1"
ENV SEED=""
ENV UPNP="0"
ENV WORLDNAME="World"


EXPOSE ${PORT}

ENTRYPOINT ["/tmodloader/entrypoint.sh"]