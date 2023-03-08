#!/bin/sh

# Weirdness to grab the name (in this case, also the tag) of the latest release on my github. Later used to download the tarball of that release. It is easier for me to just always upload to master and then create a release for the versions.
tmlurldocker=$(curl -LsN https://api.github.com/repos/PassiveLemon/tmodloader1.4-docker/releases/latest | grep -Po '"tag_name": "\K\S+(?=")')

tmlurllatest=https://github.com/tModLoader/tModLoader/releases/latest/download/tModLoader.zip
tmlurlspecific=https://github.com/tModLoader/tModLoader/releases/download/v${VERSION}/tModLoader.zip

if [ "${VERSION}" = "latest" ]; then
  echo "|| Using the latest TML version. ||"
  download=${tmlurllatest}
else
  echo "|| Using TML version ${VERSION}. ||"
  download=${tmlurlspecific}
fi

cd /tmodloader/server/
if [ ! -d "/tmodloader/server/Libraries/" ]; then
  echo "|| Downloading server files. ||"
  curl -L --output /tmodloader/server/tModLoader.zip ${download}
  unzip -o /tmodloader/server/tModLoader.zip
  rm -r /tmodloader/server/tModLoader.zip

  curl -L --output /tmodloader/server/${tmlurldocker}.tar.gz https://github.com/PassiveLemon/tmodloader1.4-docker/archive/refs/tags/${tmlurldocker}.tar.gz
  tar -xf /tmodloader/server/${tmlurldocker}.tar.gz
  cp /tmodloader/server/tmodloader1.4-docker-${tmlurldocker}/entrypoint.sh /tmodloader/server/
  cp /tmodloader/server/tmodloader1.4-docker-${tmlurldocker}/serverconfig.txt /tmodloader/server/
  rm -r /tmodloader/server/${tmlurldocker}.tar.gz

  chmod +x /tmodloader/server/start-tModLoaderServer.sh
  echo "|| Server setup completed. ||"
fi

for modpack in /tmodloader/config/ModPacks/*/; do
  if [ -e "${modpack}/Mods/enabled.json" ]; then
    echo "|| Starting server using modpack ${modpack}. ||"
    /tmodloader/server/start-tModLoaderServer.sh -config /tmodloader/config/serverconfig.txt
  else
    echo "|| No modpack was detected. Add your modpack and restart. Make sure your serverconfig.txt is also setup. ||"
    exit
  fi
done
exit