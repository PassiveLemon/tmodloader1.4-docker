#!/usr/bin/env bash

declare -A VAR_ARRAY

# Define server variables for config pasting later. Very crude and ugly
VAR_ARRAY[AUTOCREATEx]="autocreate=${AUTOCREATE}"
VAR_ARRAY[DIFFICULTYx]="difficulty=${DIFFICULTY}"
VAR_ARRAY[BANLISTx]="banlist=${BANLIST}"
VAR_ARRAY[LANGUAGEx]="language=${LANGUAGE}"
VAR_ARRAY[MAXPLAYERSx]="maxplayers=${MAXPLAYERS}"
if [ "$MODPACK" = "" ]; then
  echo "|| Modpack name was not provided. Exiting... ||"
  exit
fi
if [ "$MOTD" != "" ]; then
  VAR_ARRAY[MOTDx]="motd=${MOTD}"
fi
VAR_ARRAY[NPCSTREAMx]="npcstream=${NPCSTREAM}"
if [ "$PASSWORD" != "" ]; then
  VAR_ARRAY[PASSWORDx]="password=${PASSWORD}"
fi
VAR_ARRAY[PORTx]="port=7777"
VAR_ARRAY[PRIORITYx]="priority=${PRIORITY}"
VAR_ARRAY[SECUREx]="secure=${SECURE}"
if [ "$SEED" != "" ]; then
  VAR_ARRAY[SEEDx]="seed=${SEED}"
fi
VAR_ARRAY[UPNPx]="upnp=${UPNP}"
VAR_ARRAY[WORLDNAMEx]="worldname=${WORLDNAME}"

# Automatically set variables
VAR_ARRAY[WORLDx]="world=/opt/tmodloader/config/Worlds/${WORLDNAME}.wld"
VAR_ARRAY[MODPACKx]="modpack=/opt/tmodloader/config/ModPacks/${MODPACK}/Mods/enabled.json"
VAR_ARRAY[MODPATHx]="modpath=/opt/tmodloader/config/ModPacks/${MODPACK}/Mods/"

# Write variables to file
if [ "$SERVERCONFIG" = "0" ]; then
  if [ -e "/opt/tmodloader/config/serverconfig.txt" ]; then
    rm /opt/tmodloader/config/serverconfig.txt
  fi
  for argument in "${VAR_ARRAY[@]}"; do
    echo "$argument" >> /opt/tmodloader/config/serverconfig.txt
  done
fi

if [ ! -e "/opt/tmodloader/config/ModPacks/${MODPACK}/Mods/enabled.json" ]; then
  echo "|| Modpack was not detected. Exiting... ||"
  exit
fi

