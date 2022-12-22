FROM alpine:latest

RUN apk update &&\
    apk upgrade &&\
    apk add curl bash unzip icu-dev &&\
    mkdir /server/

COPY entrypoint.sh /

ENV TMLVERSION=""

EXPOSE 7777

WORKDIR /server/

ENTRYPOINT ["/entrypoint.sh"]