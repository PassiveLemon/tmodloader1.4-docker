#!/usr/bin/env bash

# Container update notifier
UPDATE=$(curl -s https://api.github.com/repos/PassiveLemon/tmodloader1.4-docker/releases | jq -r 'map(select(.prerelease = false)) | .[0].tag_name')
if [ $(echo "${DOCKER} < ${UPDATE}" | bc -l) = "1" ] && [ "${NOTIFS}" != "0" ]; then
  echo "|| Container update available. Current (${DOCKER}): New (${UPDATE}). ||"
fi

# Version check & setting
# Remove the V if its present
VERSION=$(echo "${VERSION}" | awk '{gsub(/^v/, ""); print}')

if [ "${PRERELEASE}" = "1" ]; then
  if [ "${VERSION}" = "latest" ]; then
    VERSION=$(curl -s https://api.github.com/repos/tModLoader/tModLoader/releases | jq -r "[.[] | select(.tag_name | contains(\"${RELEASE}\")) | select(.prerelease)] | max_by(.created_at) | .tag_name")
    echo "|| Using TML prerelease ${RELEASE} version ${VERSION} (latest). ||"
  else
    RELEASE=$(echo "${VERSION}" | awk -F '.' '{print $1}')
    VERSION=v${VERSION}
    echo "|| Using TML prerelease ${RELEASE} version ${VERSION}. ||"
  fi
elif [ "${PRERELEASE}" = "0" ]; then
  if [ "${VERSION}" = "latest" ]; then
    VERSION=$(curl -s https://api.github.com/repos/tModLoader/tModLoader/releases | jq -r "[.[] | select(.tag_name | contains(\"${RELEASE}\"))] | max_by(.created_at) | .tag_name")
    echo "|| Using TML release ${RELEASE} version ${VERSION} (latest). ||"
  else
    RELEASE=$(echo "${VERSION}" | awk -F '.' '{print $1}')
    VERSION=v${VERSION}
    echo "|| Using TML release ${RELEASE} version ${VERSION}. ||"
  fi
else
  echo "|| Issue with PRERELEASE variable. Please ensure it is set correctly. ||"
fi

# File download
cd /tmodloader/server/
if [ ! -d "/tmodloader/server/Libraries/" ]; then
  echo "|| Downloading server files for ${VERSION}. ||"
  curl -L --output /tmodloader/server/tModLoader.zip https://github.com/tModLoader/tModLoader/releases/download/${VERSION}/tModLoader.zip
  unzip -o /tmodloader/server/tModLoader.zip
  rm -r /tmodloader/server/tModLoader.zip
  rm /tmodloader/server/serverconfig.txt

  chmod +x /tmodloader/server/start-tModLoaderServer.sh
  echo "|| Server setup completed. ||"
fi

# Run the variables script to check and process server variables
source /tmodloader/variables.sh

pipe=/tmp/pipe.pipe

function shutdown () {
  inject "say Shutting down server in 3 seconds..."
  sleep 3s
  inject "exit"
  tmuxPid=$(pgrep tmux)
  while [ -e "/proc/$tmuxPid" ]; do
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
