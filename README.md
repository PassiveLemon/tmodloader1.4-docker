# tmodloader1.4-docker </br>
Docker stuff for a dedicated tModLoader 1.4 server </br>

#### This will download the required server files automaticallly. </br>

I do not know how you want your server to run so you need to make sure that it is set up how you want it. This includes your serverconfig.txt, modpack, worlds, and port forwarding. </br>
</br>

## Docker container </br>
```
docker run -d --name tModLoader1.4 -p 7777:7777 -v (path to server files):/server passivelemon/tmodloader1.4-docker:2022.07.58.8
```
 - (path to server files) Is the folder that holds the servers contents. This should be the place you choose in the next section. Start from the root of your system and go all the way to that folder (ex: C:\Users\JohnDoe\tModLoaderServer\). You can edit any of these arguments to suit you. </br>
</br>

## Setting up main server files </br>
Depending on your host, find a suitable place to store your server files. Make sure it is safe and accessible. For example: C:\TerrariaServer\ or a Linux equivalent. </br>

Download the zip of the version you want to your place of choice. </br>

Run entrypoint.sh. If you are using the Docker container, the entrypoint.sh will be automatically run upon start. This will download the tModLoader server files and the files in this repo. It will then ask you to add your modpack. Read the next section for help with getting the modpack. You can also add any worlds that you want. Read the following section for help with that. </br>

At this point, you should also fill the serverconfig.txt and make sure the fields are correct or else the server will not function correctly. [Details on server config.](https://github.com/tModLoader/tModLoader/wiki/Starting-a-modded-server) </br>
</br>

## Modpack </br>
In tModLoader on your client, enable any mods that you want to play with. Idealy, you shouldn't include any client side only mods in the modpack folder for the server. Mods are included in the modpack folder. </br>

Go to the mod pack section. </br>

"Save Enabled as New Mod Pack" </br>

"Open Mod Pack folder" </br>

Copy the folder of the modpack you want to use in the server and paste that into (path to server files)\contents\ModPacks\ </br>
</br>

## Worlds </br>
If you want to transfer a world, keep reading. </br>
Make sure that the mods used on the world are the same as the ones in your modpack. </br>

Assuming a windows host:
Go to C:\Users\(your user)\Documents\My Games\Terraria\tModLoader\Worlds\ or the Linux equivalent </br>

Copy the files of the world of your choice to (path to server files)\contents\Worlds\ </br>
</br>

## Other stuff </br>
[Refer here for port forwarding](https://terraria.fandom.com/wiki/Guide:Setting_up_a_Terraria_server#PF) </br>

## The end </br>
Assuming you did everything correctly, your server should automatically run when started. </br>

Some mods might have issues with the server when it starts up. This is rare but it happens and I can not do anything about this so you will have to remove that mod or find a work around yourself. </br>

Have fun! </br>
