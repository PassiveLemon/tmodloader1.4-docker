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
Clone/download and copy and paste all of the files into your server directory excluding the LICENSE and README.md. If it asks to overwrite, allow it. You may also discard the startserver.bat and serverconfigwindows.txt as those were for my testing if you do not need them. </br>

If you want to run the server from a windows host, you don't need the docker details and can edit the serverconfigwindows.txt like the linux one and run the startserver.bat. </br>

Edit the serverconfiglinux.txt file according to your needs. </br>
#### DONT FORGET TO EDIT THE serverconfiglinux.txt OR ELSE YOUR SERVER WILL NOT RUN HOW YOU WANT IT. </br>

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

Put them in contents/ModLoader/Mods </br>
</br>

## To get your ModPack: </br>
In tModLoader on your client, go to the mod pack section </br>

"Save Enabled as New Mod Pack" </br>

"Open Mod Pack folder" </br>

Copy the folder of the modpack you want to use in the server. </br>

Paste that into contents/ModLoader/Mods/ModPacks </br>
</br>

## Building the container </br>
Clone/download the git and navigate to the same directory as the Dockerfile </br>

Run: </br>
```
docker build -t tmodloader1.4 .
```
 - Make sure the you are in the same directory as the dockerfile. </br>
 
Once it finishes building, run: </br>
```
docker run -d --name tModLoader1.4 -p 7777:7777 -v (Server dir):/server tmodloader1.4
```
 - The server dir is the folder that holds the servers contents. This should be the place you chose from the very start. Start from the root of your system and go all the way to that folder (ex: C:\Users\JohnDoe\tModLoaderServer\). You can edit any of these arguments to suit you. </br>
 </br>
 
## The end
Assuming you did everything correctly, your container should automatically start running your server. You can check this out under the logs in the docker client. </br>

Sometimes, some mods will have issues with the server when it starts up. Unfortunately, I can not do anything about this so you will have to remove that mod or find a work around yourself. </br>

Have fun! </br>
