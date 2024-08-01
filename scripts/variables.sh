#!/usr/bin/env bash

# Define server variables for config pasting later. Very crude and ugly
AUTOCREATEx="autocreate=${AUTOCREATE}"
DIFFICULTYx="difficulty=${DIFFICULTY}"
BANLISTx="banlist=${BANLIST}"
LANGUAGEx="language=${LANGUAGE}"
MAXPLAYERSx="maxplayers=${MAXPLAYERS}"
if [ "$MODPACK" = "" ]; then
  echo "|| Modpack name was not provided. Exiting... ||"
  exit
fi
if [ "$MOTD" != "" ]; then
  MOTDx="motd=${MOTD}"
fi
NPCSTREAMx="npcstream=${NPCSTREAM}"
if [ "$PASSWORD" != "" ]; then
  PASSWORDx="password=${PASSWORD}"
fi
PORTx="port=7777"
PRIORITYx="priority=${PRIORITY}"
SECUREx="secure=${SECURE}"
if [ "$SEED" != "" ]; then
  SEEDx="seed=${SEED}"
fi
UPNPx="upnp=${UPNP}"
WORLDNAMEx="worldname=${WORLDNAME}"

# Automatically set variables
WORLDx="world=/opt/tmodloader/config/Worlds/${WORLDNAME}.wld"
MODPACKx="modpack=/opt/tmodloader/config/ModPacks/${MODPACK}/Mods/enabled.json"
MODPATHx="modpath=/opt/tmodloader/config/ModPacks/${MODPACK}/Mods/"

if [ ! -e "/opt/tmodloader/config/ModPacks/${MODPACK}/Mods/enabled.json" ]; then
  echo "|| Modpack was not detected. Exiting... ||"
  exit
fi

# Write variables to file
cd /opt/tmodloader/config/
if [ "$SERVERCONFIG" = "0" ]; then
  if [ -e "/opt/tmodloader/config/serverconfig.txt" ]; then
    rm /opt/tmodloader/config/serverconfig.txt
  fi
  for argument in $AUTOCREATEx $DIFFICULTYx $BANLISTx $LANGUAGEx $MAXPLAYERSx $MOTDx $NPCSTREAMx $PASSWORDx $PORTx $PRIORITYx $SEEDx $SECUREx $UPNPx $WORLDNAMEx $WORLDx $MODPACKx $MODPATHx; do
    echo $argument >> serverconfig.txt
  done
fi
