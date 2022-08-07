FROM ubuntu:latest

# Dependencies
RUN apt update -y &&\
    apt upgrade -y &&\
    apt install wget curl libicu-dev git unzip -y &&\
    mkdir /server/

COPY start.sh /

EXPOSE 7777

WORKDIR /

ENTRYPOINT ["/start.sh"]
