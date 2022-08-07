#!/usr/bin/env bash

shutdown() {
  #tmux attach-session -t
  screen -r "server" -X stuff $'exit\n'
  #exit
  #exit 0
}

trap 'shutdown' SIGTERM
#tmux new-session -d -s tmod "./start-tModLoaderServer.sh -config ./contents/serverconfiglinux.txt"
screen -dmS "server"
screen -r "server" -X stuff './start-tModLoaderServer.sh -config ./contents/serverconfiglinux.txt\n'
