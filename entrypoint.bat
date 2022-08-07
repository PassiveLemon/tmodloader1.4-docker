@echo off

SET VERSION=2022.07.58.8

if exist "startserver.bat" (
	call startserver.bat
) else (
	curl -LO "https://github.com/tModLoader/tModLoader/releases/download/v%VERSION%/tModLoader.zip"
	tar -xf tModLoader.zip
	del /S "tModLoader.zip"

 	curl -LO "https://github.com/PassiveLemon/tmodloader1.4-docker/releases/download/%VERSION%/tmodloader1.4-docker-master.zip"
 	tar -xf tmodloader1.4-docker-master.zip
 	del /S "tmodloader1.4-docker-master.zip" "Dockerfile" "LICENSE" "README.md"
 	call startserver.bat
)
