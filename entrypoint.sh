#!/usr/bin/env bash

VERSION=2022.09.47.16

if [ ! -d "Libraries/" ]; then
  echo "|| No server files detected. Installing... ||"
  curl -LO https://github.com/tModLoader/tModLoader/releases/download/v${VERSION}/tModLoader.zip
  unzip -o tModLoader.zip
  rm -r tModLoader.zip

  curl -LO https://github.com/PassiveLemon/tmodloader1.4-docker/archive/refs/tags/${VERSION}.zip
  unzip -o ${VERSION}.zip
  cp -r tmodloader1.4-docker-${VERSION}/{entrypoint.sh,serverconfig.txt,start-tModLoaderServer.sh} ./
  rm -r tmodloader1.4-docker-${VERSION}/ ${VERSION}.zip

  mkdir ModPacks/
  mkdir Worlds/
  chmod +x start-tModLoaderServer.sh
  echo "|| Server setup complete ||"
fi

if [ -e ModPacks/*/Mods/enabled.json ]; then
  ./start-tModLoaderServer.sh -config serverconfig.txt
else
  echo "|| No modpack detected. Add your modpack to ModPacks/ and restart. Don't forget to edit your serverconfig.txt if you have not already. ||"
  exit
fi
exit