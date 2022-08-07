@echo off

set VERSION=2022.07.58.8

if exist "contents\ModPacks\*" (
	for /d %%I in ("contents\ModPacks\*") do (
		if exist "%%~I"\Mods\enabled.json (
			call startserver.bat
		)
	)
) else (
	if not exist "Libraries\" (
		echo "No server files detected. Installing..."
		curl -LO "https://github.com/tModLoader/tModLoader/releases/download/v%VERSION%/tModLoader.zip"
		tar -xf tModLoader.zip
		del /S "tModLoader.zip"

 		curl -LO "https://github.com/PassiveLemon/tmodloader1.4-docker/releases/download/%VERSION%/tmodloader1.4-docker-master.zip"
 		tar -xf tmodloader1.4-docker-master.zip
 		del /S "tmodloader1.4-docker-master.zip" "Dockerfile" "LICENSE" "README.md"
		mkdir contents\ModPacks\
		mkdir contents\Worlds\
		echo "Server setup complete"
	)
	echo "No modpack detected. Add your modpack to contents\ModPacks\ and restart."
	pause
	exit
)
