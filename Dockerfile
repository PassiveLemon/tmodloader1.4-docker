FROM ubuntu:latest

RUN apt update -y &&\
    apt upgrade -y &&\
    apt install curl libicu-dev git unzip -y &&\
    mkdir /server/
    mkdir /server/modpacks/
    mkdir /server/worlds/

COPY entrypoint.sh /

EXPOSE 7777

WORKDIR /server/

ENTRYPOINT ["/entrypoint.sh"]
