#!/usr/bin/env bash

VERSION=2022.09.47.7

if [ -e ModPacks/*/Mods/enabled.json ]; then
  ./start-tModLoaderServer.sh -config serverconfig.txt
else
  if [ ! -d "Libraries/" ]; then
    echo "No server files detected. Installing..."
    curl -LO https://github.com/tModLoader/tModLoader/releases/download/v${VERSION}/tModLoader.zip
    unzip -o tModLoader.zip
    rm -r tModLoader.zip

    curl -LO https://github.com/PassiveLemon/tmodloader1.4-docker/releases/download/${VERSION}/tmodloader1.4-docker-master.zip
    unzip -o tmodloader1.4-docker-master.zip
    rm -r tmodloader1.4-docker-master.zip
    mkdir ModPacks/
    mkdir Worlds/
    chmod +x start-tModLoaderServer.sh
    echo "Server setup complete"
  fi
  echo "No modpack detected. Add your modpack to ModPacks/ and restart. Don't forget to edit your serverconfig.txt"
  exit
fi
