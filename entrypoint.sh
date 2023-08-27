#!/usr/bin/env bash
echo "tModLoader version $VERSION"

# Run the variables script to check and process server variables
source /opt/tmodloader/variables.sh

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
if [ -e /opt/tmodloader/server/serverconfig.txt ]; then
  rm /opt/tmodloader/server/serverconfig.txt
fi
cp /opt/tmodloader/config/serverconfig.txt /opt/tmodloader/server/

# Start tmodloader in tmux session with a write pipe to output to docker logs
echo "|| Starting server with ${MODPACK} modpack... ||"
mkfifo $pipe
tmux new-session -d "/opt/tmodloader/server/start-tModLoaderServer.sh -config /opt/tmodloader/server/serverconfig.txt | tee $pipe"

# Sometimes the server doesn't start immediately and hangs. This basically just pokes it into starting.
inject "poke"

# Read out pipe to display in docker logs
cat $pipe &
wait ${!}

echo "|| Finished shutting down. ||"
