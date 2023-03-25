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
  rm /tmodloader/server/serverconfig.txt

  chmod +x /tmodloader/server/start-tModLoaderServer.sh
  echo "|| Server setup completed. ||"
fi

# Ugly as shit
AUTOCREATEx="-autocreate ${AUTOCREATE}"
DIFFICULTYx="-difficulty ${DIFFICULTY}"
BANLISTx="-banlist ${BANLIST}"
LANGUAGEx="-language ${LANGUAGE}"
MAXPLAYERSx="-maxplayers ${MAXPLAYERS}"
if [ ${MODPACK} = "" ]; then
  echo "|| Modpack name was not provided. Exiting... ||"
  exit
fi
if [${MOTD} != "" ]; then
  MOTDx="-motd \"${MOTD}\""
fi
NPCSTREAMx="-npcstream ${NPCSTREAM}"
if [ ${PASSWORD} != "" ]; then
  PASSWORDx="-password ${PASSWORD}"
fi
if [ ${PORT} = "" ]; then
  echo "|| Port not set. Exiting...||"
  exit
fi
PRIORITYx="-forcepriority ${PRIORITY}"
if [ ${SEED} != "" ]; then
  SEEDx="-seed ${SEED}"
fi
if [ ${UPNP} = "0" ]; then
  UPNPx="-noupnp"
fi
WORLDNAMEx="-worldname ${WORLDNAME}"

# Automatically set
WORLDx="-world /tmodloader/config/Worlds/${WORLDNAME}.wld"
MODPACKx="-modpack /tmodloader/config/ModPacks/${MODPACK}/Mods/enabled.json"
MODPATHx="-modpath /tmodloader/config/ModPacks/${MODPACK}/Mods/"

if [ ! -e "/tmodloader/config/ModPacks/${MODPACK}/Mods/enabled.json" ]; then
  echo "|| Modpack was not detected. Exiting... ||"
  exit
fi
echo "start-tModLoaderServer.sh $WORLDNAMEx $WORLDx $MODPACKx $MODPATHx $AUTOCREATEx $DIFFICULTYx $BANLISTx $LANGUAGEx $MAXPLAYERSx $MOTDx $NPCSTREAMx $PASSWORDx $PORTx $PRIORITYx $SECUREx $SEEDx $UPNPx"
echo "|| Starting server with ${MODPACK} modpack. ||"
if [ ${SERVERCONFIG} = "1" ]; then
  if [ ! -e "/tmodloader/server/serverconfig.txt" ]; then
    cp -f /tmodloader/config/serverconfig.txt /tmodloader/server/
  else
    echo "|| Serverconfig.txt was not detected. Exiting... ||"
    exit
  fi
  /tmodloader/server/start-tModLoaderServer.sh -config /tmodloader/config/serverconfig.txt
else
  if [ -e "/tmodloader/config/serverconfig.txt" ]; then
    mv "/tmodloader/config/serverconfig.txt" "/tmodloader/config/serverconfig.txt.bak"
  fi
  /tmodloader/server/start-tModLoaderServer.sh  $WORLDNAMEx $WORLDx $MODPACKx $MODPATHx $AUTOCREATEx $DIFFICULTYx $BANLISTx $LANGUAGEx $MAXPLAYERSx $MOTDx $NPCSTREAMx $PASSWORDx $PORTx $PRIORITYx $SECUREx $SEEDx $UPNPx
fi
exit