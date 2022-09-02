#!/usr/bin/env bash

VERSION=2022.08.54.3

if [ -e ModPacks/*/Mods/enabled.json ]; then
  ./startserver.sh
else
  if [ ! -d "Libraries/" ]; then
    echo "No server files detected. Installing..."
    curl -LO https://github.com/tModLoader/tModLoader/releases/download/v${VERSION}/tModLoader.zip
    unzip -o tModLoader.zip
    rm -r tModLoader.zip

    #curl -LO https://github.com/PassiveLemon/tmodloader1.4-docker/releases/download/${VERSION}/tmodloader1.4-docker-master.zip
    # for testing vvvv
    git clone --single-branch --branch dev https://github.com/PassiveLemon/tmodloader1.4-docker
    cp -r tmodloader1.4-docker/* /server/
    rm -r tmodloader1.4-docker/
    #unzip -o tmodloader1.4-docker-master.zip
    #rm -r tmodloader1.4-docker-master.zip
    mkdir ModPacks/
    mkdir Worlds/
    chmod +x startserver.sh
    chmod +x start-tModLoaderServer.sh
    echo "Server setup complete"
  fi
  echo "No modpack detected. Add your modpack to ModPacks/ and restart."
  exit
fi
