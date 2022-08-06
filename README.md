# tmodloader1.4-docker </br>
Docker stuff for a dedicated tModLoader 1.4 server </br>

#### This does not download and set up the server. All this does is run the server from your host location in a docker container. </br>

You need to make sure that your server is set up how you want it. This includes your serverconfig.txt, mods, etc. You also need to set up your server port forwarding if you haven't already. </br>
</br>

# Instructions </br>
## Basics
Depending on your host, find a suitable place to store your server files. Make sure it is safe and accessible. </br>

Download the latest tModLoader 1.4 server files. The latest is [2022.07.58.8](https://github.com/tModLoader/tModLoader/releases/tag/v2022.07.58.8) at the time of writing this. </br>

Extract the server files to your place from earlier. </br>
</br>

## Setting up the server files </br>
Clone/download and copy and paste all of the files into your server directory excluding the Dockerfile, LICENSE, and README.md. If it asks to overwrite, allow it. </br>

 - If you want to run the server from a windows host, edit the serverconfigwindows.txt and use the startserver.bat. </br>

 - If you want to run the server on linux without a docker container, edit the serverconfiglinux.txt and use the startserver.sh. </br>

 - If you want to run the server in a docker container, use the same instructions as linux, and use the container building instructions. </br>

Edit the serverconfig.txt file according to your needs. If you don't, your server will not run how you want it. </br>
Do not forget your serverconfig.txt. </br>

Add your modpack. If you need help with this, read the next section. </br>
</br>

## To get your modpack: </br>
In tModLoader on your client, enable any mods that you want to play with. You shouldn't include any client side only mods in the modpack folder for the server. Mods are included in the modpack folder. </br>

Go to the mod pack section. </br>

"Save Enabled as New Mod Pack" </br>

"Open Mod Pack folder" </br>

Copy the folder of the modpack you want to use in the server. </br>

Paste that into (yourserverdir)\contents\ModLoader\Mods\ModPacks\ </br>

Once again, make sure you edit your serverconfig.txt and make sure it is correct! </br>
</br>

## Docker container </br>
Run: </br>
```
docker run -d --name tModLoader1.4 -p 7777:7777 -v (Server dir):/server passivelemon/tmodloader1.4-docker:2022.07.58.8
```
 - The server dir is the folder that holds the servers contents. This should be the place you chose from the very start. Start from the root of your system and go all the way to that folder (ex: C:\Users\JohnDoe\tModLoaderServer\). You can edit any of these arguments to suit you. </br>
</br>


## The end
Assuming you did everything correctly, your container should automatically start running your server. You can check this out under the logs in the docker client. </br>

Sometimes, some mods will have issues with the server when it starts up. Unfortunately, I can not do anything about this so you will have to remove that mod or find a work around yourself. </br>

Have fun! </br>
