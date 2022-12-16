FROM alpine:latest

RUN apk update &&\
    apk upgrade &&\
    apk add curl git unzip bash icu-dev &&\
    mkdir /server/

COPY entrypoint.sh /

EXPOSE 7777

WORKDIR /server/

ENTRYPOINT ["/entrypoint.sh"]