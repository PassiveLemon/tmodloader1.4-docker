#!/usr/bin/env bash

# Weirdness to grab the name (in this case, also the tag) of the latest release on my github. Later used to download the tarball of that release. It is easier for me to just always upload to master and then create a release for the versions.
tmlurldocker=$(curl -LsN https://api.github.com/repos/PassiveLemon/tmodloader1.4-docker/releases/latest | grep -Po '"tag_name": "\K\S+(?=")')

# Check if a version was provided.
if [ -z "${VERSION}" ]; then
  echo "|| Version was not specified. Defaulting to latest. ||"
  tmldlversion=latest
else
  tmldlversion=${VERSION}
fi

tmlurllatest=https://github.com/tModLoader/tModLoader/releases/latest/download/tModLoader.zip
tmlurlspecific=https://github.com/tModLoader/tModLoader/releases/download/v${tmldlversion}/tModLoader.zip

if [ "${tmldlversion}" = "latest" ]; then
  echo "|| Using the latest TML version. ||"
  download=${tmlurllatest}
else
  echo "|| Using TML version ${tmldlversion}. ||"
  download=${tmlurlspecific}
fi

cd /server/
if [ ! -d "/server/Libraries/" ]; then
  echo "|| Downloading server files. ||"
  curl -L --output /server/tModLoader.zip ${download}
  unzip -o /server/tModLoader.zip
  rm -r /server/tModLoader.zip

  curl -L --output /server/${tmlurldocker}.tar.gz https://github.com/PassiveLemon/tmodloader1.4-docker/archive/refs/tags/${tmlurldocker}.tar.gz
  tar -xf /server/${tmlurldocker}.tar.gz
  cp -r /server/tmodloader1.4-docker-${tmlurldocker}/{entrypoint.sh,serverconfig.txt} /server/
  rm -r /server/${tmlurldocker}.tar.gz

  chmod +x /server/start-tModLoaderServer.sh
  echo "|| Server setup completed. ||"
fi

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