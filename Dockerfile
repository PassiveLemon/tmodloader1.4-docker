FROM docker.io/ubuntu:latest
# VERSION comes from the main.yml workflow --build-arg
ARG VERSION

RUN apt-get install bash grep curl unzip libicu-dev tmux jq

RUN mkdir -p /opt/tmodloader/server/ &&\
    mkdir -p /opt/tmodloader/config/ModPacks &&\
    mkdir -p /opt/tmodloader/config/Worlds

COPY entrypoint.sh /opt/tmodloader/
COPY variables.sh /opt/tmodloader/
COPY inject.sh /usr/local/bin/inject

RUN chmod 755 /opt/tmodloader/ &&\
    chmod +x /opt/tmodloader/entrypoint.sh &&\
    chmod 755 /usr/local/bin/inject

WORKDIR /opt/tmodloader/server/

RUN curl -Lo ./tModLoader.zip https://github.com/tModLoader/tModLoader/releases/download/v${VERSION}/tModLoader.zip

RUN unzip -o ./tModLoader.zip &&\
    rm -r ./tModLoader.zip &&\
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
ENV PORT="7777"
ENV PRIORITY="1"
ENV SECURE="1"
ENV SEED=""
ENV UPNP="0"
ENV WORLDNAME="World"

ENTRYPOINT ["/opt/tmodloader/entrypoint.sh"]
