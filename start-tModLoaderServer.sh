#!/usr/bin/env bash
cd "$(dirname "$0")"

launch_args="$@ -server"
if [[ ! "$launch_args" == *"-config"* ]]; then
	launch_args="$launch_args -config serverconfig.txt"
fi

chmod +x ./LaunchUtils/ScriptCaller.sh
./LaunchUtils/ScriptCaller.sh $launch_args
