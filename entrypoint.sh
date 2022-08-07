#!/usr/bin/env bash

VERSION=2022.07.58.8

if [ -f "startserver.sh" ]; then
  ./startserver.sh
else
  curl -LO https://github.com/tModLoader/tModLoader/releases/download/v${VERSION}/tModLoader.zip
  unzip tModLoader.zip
  rm -r tModLoader.zip

  curl -LO https://github.com/PassiveLemon/tmodloader1.4-docker/releases/download/${VERSION}/tmodloader1.4-docker-master.zip
  unzip -o tmodloader1.4-docker-master.zip
  rm -r tmodloader1.4-docker-master.zip Dockerfile LICENSE README.md
  chmod +x /server/startserver.sh
  chmod +x /server/start-tModLoaderServer.sh
  ./startserver.sh
fi
