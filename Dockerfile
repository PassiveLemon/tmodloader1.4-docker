#FROM cm2network/steamcmd:root
FROM ubuntu

RUN apt update -y &&\
    apt upgrade -y &&\
    apt install wget curl libicu-dev -y

EXPOSE 7777

WORKDIR /server/

ENTRYPOINT ./startserver.sh
