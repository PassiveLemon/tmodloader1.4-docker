#!/usr/bin/env bash

tmlversion=${VERSION} # $VERSION is passed down from Dockerfile
tmlurllatest=https://github.com/tModLoader/tModLoader/releases/latest/download/tModLoader.zip
tmlurlspecific=https://github.com/tModLoader/tModLoader/releases/download/v${tmlversion}/tModLoader.zip

# Check if a version was provided
if [ -z "${VERSION}" ]; then
  echo "|| Version was not specified. Defaulting to latest. ||"
  tmlversion=latest
else
  tmlversion=${VERSION}
fi

# Check if the version is "latest"
if [ "${tmlversion}" = "latest" ]; then
  echo "|| Using the latest TML version. ||"
  download=${tmlurllatest}
else
  echo "|| Using TML version ${tmlversion}. ||"
  download=${tmlurlspecific}
fi

# Download and setup the server
cd /server/
if [ ! -d "/server/Libraries/" ]; then
  echo "|| Downloading server files. ||"
  curl -LO ${download}
  unzip -o /server/tModLoader.zip
  rm -r /server/tModLoader.zip

  curl -LO https://github.com/PassiveLemon/tmodloader1.4-docker/releases/latest/download/tmodloader1.4-docker.zip
  unzip -o /server/tmodloader1.4-docker.zip -d /server/tmodloader1.4-docker
  cp -r /server/tmodloader1.4-docker/{entrypoint.sh,serverconfig.txt} /server/
  rm -r /server/tmodloader1.4-docker /server/tmodloader1.4-docker.zip

  chmod +x /server/start-tModLoaderServer.sh
  echo "|| Server setup completed. ||"
fi

# Check for modpack and start server if present.
for modpack in /config/ModPacks/*/; do
  if [ -e "$modpack/Mods/enabled.json" ]; then
    echo "|| Starting server using modpack $modpack. ||"
    bash /server/start-tModLoaderServer.sh -config /config/serverconfig.txt
  else
    echo "|| No modpack was detected. Add your modpack to /config/ModPacks/ and restart. Make sure your serverconfig.txt is also setup. ||"
    exit
  fi
done
exit