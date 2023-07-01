#!/usr/bin/env bash

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

# Define variables for config pasting later. Very crude and ugly
AUTOCREATEx="autocreate=${AUTOCREATE}"
DIFFICULTYx="difficulty=${DIFFICULTY}"
BANLISTx="banlist=${BANLIST}"
LANGUAGEx="language=${LANGUAGE}"
MAXPLAYERSx="maxplayers=${MAXPLAYERS}"
if [ "${MODPACK}" = "" ]; then
  echo "|| Modpack name was not provided. Exiting... ||"
  exit
fi
if [ "${MOTD}" != "" ]; then
  MOTDx="motd=${MOTD}"
fi
NPCSTREAMx="npcstream=${NPCSTREAM}"
if [ "${PASSWORD}" != "" ]; then
  PASSWORDx="password=${PASSWORD}"
fi
if [ "${PORT}" = "" ]; then
  echo "|| Port not set. Exiting... ||"
  exit
fi
PORTx="port=${PORT}"
PRIORITYx="priority=${PRIORITY}"
SECUREx="secure=${SECURE}"
if [ "${SEED}" != "" ]; then
  SEEDx="seed=${SEED}"
fi
UPNPx="upnp=${UPNP}"
WORLDNAMEx="worldname=${WORLDNAME}"

# Automatically set variables
WORLDx="world=/tmodloader/config/Worlds/${WORLDNAME}.wld"
MODPACKx="modpack=/tmodloader/config/ModPacks/${MODPACK}/Mods/enabled.json"
MODPATHx="modpath=/tmodloader/config/ModPacks/${MODPACK}/Mods/"

if [ ! -e "/tmodloader/config/ModPacks/${MODPACK}/Mods/enabled.json" ]; then
  echo "|| Modpack was not detected. Exiting... ||"
  exit
fi

# Write variables to file
cd /tmodloader/config/
if [ ${SERVERCONFIG} = "0" ]; then
  if [ -e /tmodloader/config/serverconfig.txt ]; then
    rm /tmodloader/config/serverconfig.txt
  fi
  for argument in $AUTOCREATEx $DIFFICULTYx $BANLISTx $LANGUAGEx $MAXPLAYERSx $MOTDx $NPCSTREAMx $PASSWORDx $PORTx $PRIORITYx $SEEDx $SECUREx $UPNPx $WORLDNAMEx $WORLDx $MODPACKx $MODPATHx; do
    echo $argument >> serverconfig.txt
  done
fi

pipe=/tmp/pipe.pipe

function shutdown () {
  inject "say Shutting down server in 3 seconds..."
  sleep 3s
  inject "exit"
  tmuxPid=$(pgrep tmux)
  while [ -e /proc/$tmuxPid ]; do
    sleep .5
  done
  echo "|| Server stopped. ||"
  rm $pipe
}

trap shutdown TERM INT

# Replace server config every launch to ensure changes are set
if [ -e /tmodloader/server/serverconfig.txt ]; then
  rm /tmodloader/server/serverconfig.txt
fi
cp /tmodloader/config/serverconfig.txt /tmodloader/server/

echo "|| Starting server with ${MODPACK} modpack... ||"
mkfifo $pipe
tmux new-session -d "/tmodloader/server/start-tModLoaderServer.sh -config /tmodloader/server/serverconfig.txt | tee $pipe"

# Sometimes the server doesn't start immediately and hangs. This basically just pokes it into starting.
inject "poke"

cat $pipe &
wait ${!}

echo "|| Finished shutting down. ||"
