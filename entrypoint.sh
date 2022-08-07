#!/usr/bin/env bash

VERSION=2022.07.58.8
if [ -e contents/ModPacks/*/Mods/enabled.json ]; then
  ./startserver.sh
else
  if [ ! -d "Libraries/" ]; then
    echo "No server files detected. Installing..."
    curl -LO https://github.com/tModLoader/tModLoader/releases/download/v${VERSION}/tModLoader.zip
    unzip -o tModLoader.zip
    rm -r tModLoader.zip

    curl -LO https://github.com/PassiveLemon/tmodloader1.4-docker/releases/download/${VERSION}/tmodloader1.4-docker-master.zip
    unzip -o tmodloader1.4-docker-master.zip
    rm -r tmodloader1.4-docker-master.zip
    mkdir contents/ModPacks/
    mkdir contents/Worlds/
    chmod +x startserver.sh
    chmod +x start-tModLoaderServer.sh
      echo "Server setup complete"
  fi
  echo "No modpack detected. Add your modpack to contents/ModPacks/ and restart."
  exit
fi
