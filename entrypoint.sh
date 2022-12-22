#!/usr/bin/env bash

# $TMLVERSION is passed down from Dockerfile
tmlversionlatest=https://github.com/tModLoader/tModLoader/releases/latest/download/tModLoader.zip
tmlversiontag=https://github.com/tModLoader/tModLoader/releases/download/v${TMLVERSION}/tModLoader.zip

if [ "${TMLVERSION}" = "latest" ]; then
  downloadversion=${tmlversionlatest}
else
  downloadversion=${tmlversiontag}
fi

echo "|| TML version is ${TMLVERSION} ||"

if [ ! -d "Libraries/" ]; then
  echo "|| No server files detected. Installing... ||"
  curl -LO ${downloadversion}
  unzip -o tModLoader.zip
  rm -r tModLoader.zip

  curl -LO https://github.com/PassiveLemon/tmodloader1.4-docker/releases/latest/download/tmodloader1.4-docker.zip
  unzip -o tmodloader1.4-docker.zip -d ./tmodloader1.4-docker
  cp -r tmodloader1.4-docker/{entrypoint.sh,serverconfig.txt} ./
  rm -r tmodloader1.4-docker tmodloader1.4-docker.zip

  mkdir ModPacks/
  mkdir Worlds/
  chmod +x start-tModLoaderServer.sh
  echo "|| Server setup complete ||"
fi

echo "|| Starting server... ||"
for modpack in ModPacks/*/; do
  if [ -e "$modpack/Mods/enabled.json" ]; then
    ./start-tModLoaderServer.sh -config serverconfig.txt
  else
    echo "|| No modpack detected. Add your modpack to ModPacks/ and restart. Don't forget to edit your serverconfig.txt if you have not already. ||"
    exit
  fi
done
exit