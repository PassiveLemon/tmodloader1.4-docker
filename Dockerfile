FROM alpine:3.18.2

RUN apk update && apk upgrade &&\
    apk add bash grep curl unzip icu-dev tmux jq bc

RUN mkdir -p /tmodloader/server/ &&\
    mkdir -p /tmodloader/config/ModPacks &&\
    mkdir -p /tmodloader/config/Worlds

COPY entrypoint.sh /tmodloader/
COPY variables.sh /tmodloader/
COPY notifier.sh /tmodloader/
COPY inject.sh /usr/local/bin/inject

RUN chmod +x /tmodloader/entrypoint.sh &&\
    chmod 755 /usr/local/bin/inject

ENV DOCKER="2.0.0"
ENV NOTIFS="1"

ENV PRERELEASE="0"
ENV RELEASE="2022"
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

ENTRYPOINT ["/tmodloader/entrypoint.sh"]
