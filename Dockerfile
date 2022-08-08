FROM cm2network/steamcmd:root

RUN apt update -y &&\
    apt upgrade -y &&\
    apt install curl libicu-dev git unzip -y &&\
    mkdir /server/
	
COPY entrypoint.sh /

EXPOSE 7777

WORKDIR /server/

ENTRYPOINT ["/entrypoint.sh"]
ENV HOME /home/steam
RUN /home/steam/steamcmd/steamcmd.sh +force_install_dir $(pwd)/../tmod +login anonymous +app_update 1281930 +quit
