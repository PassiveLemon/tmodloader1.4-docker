# tmodloader1.4-docker </br>

[![Repo](https://img.shields.io/badge/Docker-Repo-007EC6?labelColor-555555&color-007EC6&logo=docker&logoColor=fff&style=flat-square)](https://hub.docker.com/repository/docker/passivelemon/tmodloader1.4-docker)
![Version](https://img.shields.io/docker/v/passivelemon/tmodloader1.4-docker/latest?labelColor-555555&color-007EC6&style=flat-square)
![Size](https://img.shields.io/docker/image-size/passivelemon/tmodloader1.4-docker/latest?sort=semver&labelColor-555555&color-007EC6&style=flat-square)
![Pulls](https://img.shields.io/docker/pulls/passivelemon/tmodloader1.4-docker?labelColor-555555&color-007EC6&style=flat-square)
![Stars](https://img.shields.io/github/stars/passivelemon/tmodloader1.4-docker?labelColor-555555&color-007EC6&style=flat-square)
![Forks](https://img.shields.io/github/forks/passivelemon/tmodloader1.4-docker?labelColor-555555&color-007EC6&style=flat-square)

Docker stuff for a dedicated tModLoader 1.4 server </br>

I will update this with major stable releases. </br>

#### This will download the required server files automatically. </br>

I do not know how you want your server to run so you need to make sure that it is set up how you want it. This includes your serverconfig.txt, modpack, worlds, and port forwarding. </br>
</br>

## Setting up main server files </br>
Depending on your host, find a suitable place to store your server files. Make sure it is safe and accessible. For example: C:\TerrariaServer\ or a Linux equivalent. This will be important later. </br>

### Docker container </br>
```
docker run -d --name tModLoader1.4 -p 7777:7777 -v (path to server files):/server passivelemon/tmodloader1.4-docker:latest
```
 - `-d` will run the container in the background.
 - `--name tModLoader1.4` will set the name of the container to the following word. You can change this to whatever you want.
 - `-p 7777:7777` will open port 7777 which is used by the server. If you use a different port for your server in your serverconfig, change this.
 - `(path to server files):/server` is the folder that holds the servers contents. This should be the place you just chose.
 - `passivelemon/tmodloader1.4-docker:latest` is the repository on Docker hub and the version of tModLoader. By default, it is the latest version that i have published. Change `latest` to the version you want with the format in the releases. I HAVE NOT PUBLISHED EVERY SINGLE VERSION. </br>

The entrypoint.sh will be automatically run upon start. This will download the tModLoader server files and the files in this repo. It will then ask you to add your modpack. Read the next section for help with getting the modpack. You can also add any worlds that you want. Read the following section for help with that. </br>

At this point, you should also fill the serverconfig.txt and make sure the fields are correct or else the server will not function correctly. [Details on server config.](https://github.com/tModLoader/tModLoader/wiki/Starting-a-modded-server) </br>
</br>

## Modpack </br>
In tModLoader on your client, enable any mods that you want to play with. Idealy, you shouldn't include any client side only mods in the modpack folder for the server. Mods are included in the modpack folder. </br>

Go to the mod pack section. </br>

"Save Enabled as New Mod Pack" </br>

"Open Mod Pack folder" </br>

Copy the folder of the modpack you want to use in the server and paste that into (path to server files)/ModPacks/ </br>
</br>

## Worlds </br>
If you want to transfer a world, keep reading. </br>
Make sure that the mods used on the world are the same as the ones in your modpack. </br>

Assuming a windows host:
Go to C:\Users\(your user)\Documents\My Games\Terraria\tModLoader\Worlds\ or the Linux equivalent </br>

Copy the files of the world of your choice to (path to server files)/Worlds/ </br>
</br>

## Other stuff </br>
[Refer here for port forwarding](https://terraria.fandom.com/wiki/Guide:Setting_up_a_Terraria_server#PF) </br>

## The end </br>
Assuming you did everything correctly, you should have a functional server that will automatically load the modpack and world upon start.</br>

Some mods might have issues with the server when it starts up. This is rare but it happens and I can not do anything about this so you will have to remove that mod or find a work around yourself. </br>

Have fun! </br>
