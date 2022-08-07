# tmodloader1.4-docker </br>
Docker stuff for a dedicated tModLoader 1.4 server </br>

#### This will download the required server files automaticallly. </br>

I do not know how you want your server to run so you need to make sure that it is set up how you want it. This includes your serverconfig.txt, modpack, etc. You also need to set up your server port forwarding if you haven't already. </br>
</br>

## Setting up main server files </br>
Depending on your host, find a suitable place to store your server files. Make sure it is safe and accessible. For example: C:\TerrariaServer\ or a Linux equivalent. </br>

Clone/download the git to your place of choice. </br>

 - Windows server host: Run entrypoint.bat and edit serverconfigwindows.txt. </br>

 - Linux server host without a docker container: Run entrypoint.sh and edit serverconfiglinux.txt. </br>

 - Docker container: Use the docker container instructions and use serverconfiglinux.txt. </br>

The configs are in the contents folder. Make sure it is correctly edited or your server will not run correctly. [Details on server config.](https://github.com/tModLoader/tModLoader/wiki/Starting-a-modded-server) </br>
</br>

## Modpack </br>
In tModLoader on your client, enable any mods that you want to play with. You shouldn't include any client side only mods in the modpack folder for the server. Mods are included in the modpack folder. </br>

Go to the mod pack section. </br>

"Save Enabled as New Mod Pack" </br>

"Open Mod Pack folder" </br>

Copy the folder of the modpack you want to use in the server. </br>

Paste that into (path to server files)\contents\ModPacks\ </br>

## Worlds </br>
Make sure that the mods used on the world are the same as the ones in your modpack

Go to C:\Users\(your user)\Documents\My Games\Terraria\tModLoader\Worlds\ or the linux equivalent

Copy the files to (path to server files)\contents\Worlds\

Once again, make sure you edit your serverconfig.txt and make sure it is correct! [Details on server config.](https://github.com/tModLoader/tModLoader/wiki/Starting-a-modded-server)</br>
</br>

## Docker container </br>
Run: </br>
```
docker run -d --name tModLoader1.4 -p 7777:7777 -v (path to server files):/server passivelemon/tmodloader1.4-docker:2022.07.58.8
```
 - (path to server files) Is the folder that holds the servers contents. This should be the place you chose from the very start. Start from the root of your system and go all the way to that folder (ex: C:\Users\JohnDoe\tModLoaderServer\). You can edit any of these arguments to suit you. </br>
</br>

## The end
Assuming you did everything correctly, your container should automatically start running and downloading your server. It will then prompt you to add your modpack. </br>

Some mods might have issues with the server when it starts up. This is rare but it happens and I can not do anything about this so you will have to remove that mod or find a work around yourself. </br>

Have fun! </br>
