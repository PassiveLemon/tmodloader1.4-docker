FROM ubuntu:latest

RUN apt update -y &&\
    apt upgrade -y &&\
    apt install wget curl libicu-dev git unzip mono-complete -y &&\
    mkdir /server/

COPY entrypoint.sh /

EXPOSE 7777

WORKDIR /server/

ENTRYPOINT ["/entrypoint.sh"]
