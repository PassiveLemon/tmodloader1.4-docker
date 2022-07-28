# tmodloader1.4-docker </br>
Docker stuff for a dedicated tModLoader 1.4 server </br>

#### This does not download and set up the server. All this does is run the server from your host location in a docker container. </br>

You need to make sure that your server is set up how you want it. This includes your serverconfig.txt, mods, etc. You also need to set up your server port forwarding if you haven't already. </br>
</br>

# Instructions </br>
## Basics
Depending on your host, find a suitable place to store you server files. Make sure it is safe and accessible. </br>

Download the latest tModLoader 1.4 server files. The latest is [2022.6.96.4](https://github.com/tModLoader/tModLoader/releases/tag/v2022.06.96.4) at the time of writing this. </br>

Extract the server files to your place from earlier. </br>
</br>

## Applying your server stuff </br>
Clone/download and copy and paste all of the files into your server directory excluding the Dockerfile, LICENSE, and README.md. If it asks to overwrite, allow it. </br>

 - If you want to run the server from a windows host, edit the serverconfigwindows.txt and use the startserver.bat. </br>

 - If you want to run the server on linux without a docker container, edit the serverconfiglinux.txt and use the startserver.sh. </br>

 - If you want to run the server in a docker container, use the same instructions as linux, and use the container building instructions. </br>

Edit the serverconfig.txt file according to your needs. If you don't, your server will not run how you want it. </br>
Do not forget your serverconfig.txt. </br>


Add your .tmods and modpack. If you need help with these, read further. </br>
</br>

## To get your .tmods: </br>
 - This part may be tedious depending on how many mods you have. Bear with me and read the instructions carefully. There might be a better way to do it but I am unaware of it. </br>

Go to C:\Program Files (x86)\Steam\steamapps\workshop\content\1281930 or the equivalent linux directory. </br>

Each of these files is a mod from the workshop. Go through each folder and copy and paste the correrct .tmod into the mods folder in the file from earlier. Use the list below to figure out which .tmod file to use. </br>

If the folder: </br>
 - has workshop.json and (modname).tmod, use that .tmod. </br>

 - has workshop.json, (modname).tmod, and folders like 2022.X, use the .tmod in the folder that has the highest 2022.X. </br>

 - has workshop.json, and folders like 2022.X, use the .tmod in the folder that has the highest 2022.X. </br>

Put them in (yourserverdir)\contents\ModLoader\Mods\ </br>
</br>

## To get your ModPack: </br>
In tModLoader on your client, go to the mod pack section </br>

"Save Enabled as New Mod Pack" </br>

"Open Mod Pack folder" </br>

Copy the folder of the modpack you want to use in the server. </br>

Paste that into (yourserverdir)\contents\ModLoader\Mods\ModPacks\ </br>

If your modpack fails to create, it’s because the enabled.json cannot be created in the modpack folder. To “fix” this, go back 1 directories and copy that enabled.json into the mods folder in your modpack. However, this won’t result in the creation of the install.txt file but with these instructions, it isn't necessary. Fargos Souls mod can cause this. </br>
</br>

## Building the container </br>
Run: </br>
```
docker run -d --name tModLoader1.4 -p 7777:7777 -v (Server dir):/server passivelemon/tmodloader1.4-docker
```
 - The server dir is the folder that holds the servers contents. This should be the place you chose from the very start. Start from the root of your system and go all the way to that folder (ex: C:\Users\JohnDoe\tModLoaderServer\). You can edit any of these arguments to suit you. </br>
 
As of 7/11, there is a weird issue where if you build the container and then run it, it will work perfectly fine but if you pull it and then run it, you might get an error having to do with steam in the Natives.log. If you know how to fix this, please tell me. </br>
</br>


## The end
Assuming you did everything correctly, your container should automatically start running your server. You can check this out under the logs in the docker client. </br>

Sometimes, some mods will have issues with the server when it starts up. Unfortunately, I can not do anything about this so you will have to remove that mod or find a work around yourself. </br>

Have fun! </br>
