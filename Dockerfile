FROM docker.io/alpine:latest
# VERSION comes from the main.yml workflow --build-arg
ARG VERSION

RUN apk add --no-cache bash grep curl unzip icu-dev tmux jq netcat-openbsd
# Alternatives for security
RUN apk add --no-cache openssl=3.1.4-r1

RUN mkdir -p /opt/tmodloader/server/ &&\
    mkdir -p /opt/tmodloader/config/ModPacks &&\
    mkdir -p /opt/tmodloader/config/Worlds

COPY entrypoint.sh /opt/tmodloader/
COPY variables.sh /opt/tmodloader/
COPY inject.sh /usr/local/bin/inject

RUN chmod -R 755 /opt/tmodloader/ &&\
    chmod +x /opt/tmodloader/entrypoint.sh &&\
    chmod 755 /usr/local/bin/inject

WORKDIR /opt/tmodloader/server/

RUN curl -Lo ./tModLoader.zip https://github.com/tModLoader/tModLoader/releases/download/v${VERSION}/tModLoader.zip

RUN unzip -o ./tModLoader.zip &&\
    rm ./tModLoader.zip &&\
    rm ./serverconfig.txt

RUN chmod +x ./start-tModLoaderServer.sh

ENV VERSION=$VERSION

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
ENV PRIORITY="1"
ENV SECURE="1"
ENV SEED=""
ENV UPNP="0"
ENV WORLDNAME="World"

ENTRYPOINT ["/opt/tmodloader/entrypoint.sh"]

HEALTHCHECK --interval=5s --timeout=5s --retries=2 CMD nc -vz 127.0.0.1 7777 || exit 1
