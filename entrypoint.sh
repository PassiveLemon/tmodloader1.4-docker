#!/usr/bin/env bash

# Container update notifier
. /tmodloader/notifier.sh

# Remove the V from the version if its present
VERSION=$(echo "${VERSION}" | awk '{gsub(/^v/, ""); print}')

# If version isn't valid, hard stop.
function versionvalidate () {
  if [ -z $(curl -s "https://api.github.com/repos/tModLoader/tModLoader/git/refs/tags" | jq -r ".[].ref | select(contains(\"${VERSION}\"))") ]; then
    echo "|| ${VERSION} is not a valid version. Please ensure it is set correctly. ||"
    exit
  fi
}

# Version setting
if [ "${PRERELEASE}" = "1" ]; then
  if [ "${VERSION}" = "latest" ]; then
    # Latest prerelease
    VERSION=$(curl -s https://api.github.com/repos/tModLoader/tModLoader/releases | jq -r "[.[] | select(.tag_name | contains(\"${RELEASE}\")) | select(.prerelease)] | max_by(.created_at) | .tag_name")
    versionvalidate
    echo "|| Using TML prerelease ${RELEASE} version ${VERSION} (latest). ||"
  else
    # Set prerelease
    RELEASE=$(echo "${VERSION}" | awk -F '.' '{print $1}')
    VERSION=v${VERSION}
    versionvalidate
    echo "|| Using TML prerelease ${RELEASE} version ${VERSION}. ||"
  fi
elif [ "${PRERELEASE}" = "0" ]; then
  if [ "${VERSION}" = "latest" ]; then
    # Latest release
    VERSION=$(curl -s https://api.github.com/repos/tModLoader/tModLoader/releases | jq -r "[.[] | select(.tag_name | contains(\"${RELEASE}\"))] | max_by(.created_at) | .tag_name")
    versionvalidate
    echo "|| Using TML release ${RELEASE} version ${VERSION} (latest). ||"
  else
    # Set release
    RELEASE=$(echo "${VERSION}" | awk -F '.' '{print $1}')
    VERSION=v${VERSION}
    versionvalidate
    echo "|| Using TML release ${RELEASE} version ${VERSION}. ||"
  fi
else
  echo "|| Issue with PRERELEASE variable. Please ensure it is set correctly. ||"
fi

# Downloads & setup
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

# Start tmodloader in tmux session with a write pipe to output to docker logs
echo "|| Starting server with ${MODPACK} modpack... ||"
mkfifo $pipe
tmux new-session -d "/tmodloader/server/start-tModLoaderServer.sh -config /tmodloader/server/serverconfig.txt | tee $pipe"

# Sometimes the server doesn't start immediately and hangs. This basically just pokes it into starting.
inject "poke"

# Read out pipe to display in docker logs
cat $pipe &
wait ${!}

echo "|| Finished shutting down. ||"
