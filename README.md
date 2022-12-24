# tmodloader1.4-docker </br>

[![Repo](https://img.shields.io/badge/Docker-Repo-007EC6?labelColor-555555&color-007EC6&logo=docker&logoColor=fff&style=flat-square)](https://hub.docker.com/repository/docker/passivelemon/tmodloader1.4-docker)
[![Version](https://img.shields.io/docker/v/passivelemon/tmodloader1.4-docker/latest?labelColor-555555&color-007EC6&style=flat-square)](https://hub.docker.com/repository/docker/passivelemon/tmodloader1.4-docker)
[![Size](https://img.shields.io/docker/image-size/passivelemon/tmodloader1.4-docker/latest?sort=semver&labelColor-555555&color-007EC6&style=flat-square)](https://hub.docker.com/repository/docker/passivelemon/tmodloader1.4-docker)
[![Pulls](https://img.shields.io/docker/pulls/passivelemon/tmodloader1.4-docker?labelColor-555555&color-007EC6&style=flat-square)](https://hub.docker.com/repository/docker/passivelemon/tmodloader1.4-docker)

#### This will download the required server files automatically. </br>

I do not know how you want your server to run so you need to make sure that it is set up how you want it. This includes your serverconfig.txt, modpack, worlds, and port forwarding. </br>

## Setting up main server files </br>
Depending on your host, find a suitable place to store your server files. Make sure it is empty, safe, and accessible. For example: On Windows, something like `C:\TerrariaServer\` or a Linux equivalent like `/opt/TerrariaServer/`. This will be important later. </br>

### Docker container </br>
```
docker run -d --name (container name) -p 7777:7777 -v (path to server files):/server -e TMLVERSION=(tml version) passivelemon/tmodloader1.4-docker:latest
```
 - `-d` will run the container in the background.
 - `--name (container name)` will set the name of the container to the following word. You can change this to whatever you want.
 - `-p 7777:7777` is the default port used by the server. This translates from your host 7777 into the container 7777. If you use a different port for your server in your serverconfig, change this. Make sure your serverconfig.txt accurately represents this.
 - `-v (path to server files):/server` is the folder that holds the servers contents. This should be the place you just chose.
 - `-e TMLVERSION=(tml version)` is the version of tModLoader that you want to run. Only works if it is written like XXXX.XX.XX.XX. Go to the [tModLoader github](https://github.com/tModLoader/tModLoader/releases) page and look at the versions. You may also just use "latest" and it will always automatically use the latest published version when creating the server. It wont update the server though.
 - `passivelemon/tmodloader1.4-docker:latest` is the repository on Docker hub. By default, it is the latest version that I have published. </br>

#### Example:
```
docker run -d --name tModLoader1.4 -p 7777:7777 -v C:\DockerContainers\tModLoaderServer\:/server -e TMLVERSION=2022.09.47.13 passivelemon/tmodloader1.4-docker:latest
```
The entrypoint.sh script is attached to the Dockerfile and will be automatically run upon start. This will download the tModLoader server files and the files in this repo. It will then ask you to add your modpack, of which you can also add any worlds you want, and to modify the server config. Keep reading for help on those. </br>

# Modpack </br>
Idealy, you shouldn't include any client side only mods in the modpack folder for the server. Client side mods only affect the client (player) meaning they add zero new functionality to the game. Includes things like different textures, shaders, RPC, etc. Nothing bad should happen if you do but it's just best practice. Mods are included in the modpack folder. </br>

1. In tModLoader on your client, enable any mods that you want to play with. </br>

2. Go to the mod pack section. </br>

3. "Save Enabled as New Mod Pack" </br>

4. "Open Mod Pack folder" </br>

5. Copy the folder of the modpack you want to use in the server and paste that into `(path to server files)/ModPacks/` </br>

# Worlds </br>
This is not necessary if you plan to start from a new world however you might want to bring an already existing world into the server. </br>
Make sure that the mods used on the world are the same as the ones in your modpack or else you may risk some world corruption. </br>

1. Go to `C:\Users\(your user)\Documents\My Games\Terraria\tModLoader\Worlds\` or the Linux equivalent </br>

2. Copy the files of the world of your choice to `(path to server files)/Worlds/`. The world files look like `.wld` and `.twld`. </br>

# Configuration </br>
## Port forwarding </br>
Unless you have some special case, you will need to port forward. The general idea of port forwarding is when a client sends a request to the server (with a specific port), a properly port forwarded router will allow the request to go through and to the specified host. Terraria uses 7777 by default but you can change this in your config file. </br>

1. Head to your router web interface by typing your gateway IP into your router. (If you do not know this, you should probably figure it out.) It might be `192.168.1.1` or `172.1.0.1` or something of the likes. This will vary depending on how your network is setup.

2. Find the port forwarding section. Your router management software is probably going to be different but theres a good chance that its just called "port forwarding" or under a "NAT" tab or something of the likes. </br>
EX: For PFsense, it is under NAT and is called Port Forwarding. Your inputs may also look a little different. Please consult your software manufactuerers manual for guidance if you do not know what you are doing. </br>

3. Set the external or incoming port. This is the port that players will type when they try to join your server. </br>

4. Set the internal or outgoing port. This is the port that will be used by Docker. This is the first part of the `-p 7777:7777`. </br>
The second part is the container port. This is what you put into your server config (7777 by default). </br>

5. Set your destination IP. This will be the IP of your server/host. There are many ways to find it. Go to your terminal: Windows is `ipconfig`. Most Linux use `ip a` or a similar command. Look for your interface, whether it is wifi or wired, and find your IPV4 address. It might look like `192.168.1.XXX` or `172.1.0.XXX`. Again, will probably be different. </br>
    - <b>NOTE:</b> Your server/host IP might eventually change. If this happens, your port forwarding will no longer work. You will need to set a static IP address. Research how to do this. </br>

[More info on the Terraria Wiki](https://terraria.fandom.com/wiki/Guide:Setting_up_a_Terraria_server#PF) </br>

## Server Config </br>
The `serverconfig.txt` file should have all of the needed information for the server to automatically start. I have provided some basic presets but there is still information that YOU WILL NEED TO CHANGE. It is already in the file but you will need to change the line for the name of your modpack and, especially if you added a world, the name of the world. You can also add any other settings that you may want. </br>

[Server configuration details on the Terraria Wiki](https://terraria.fandom.com/wiki/Server#Server_config_file) </br>

## Other Links </br>

[tModLoader github](https://github.com/tModLoader/tModLoader/releases) </br>
[More details on general server configuration.](https://github.com/tModLoader/tModLoader/wiki/Starting-a-modded-server/dac6879dd891bfc74695d51a822379189d69f189) </br>

# The end </br>
Assuming you did everything correctly, you should have a functional server that will automatically load the modpack and world upon start.</br>

Some mods might have issues with the server when it starts up. This is rare but it happens and I can not do anything about this so you will have to remove that mod or find a work around yourself. </br>

## Access </br>
In order to access the server, you will need the public IP of the host. This could be access from a properly setup CDN but you might not have one. In this case, search up "Whats my ip" or similar into your browser and use the IP that it shows.
- <b>NOTE:</b> It isn't recommended to use this as it gives users your general location. It may be the only option you have though so be careful. </br>

You will also need a port. If you didn't change the defaults, it will just be 7777. If you did change from defaults, it will be whatever port you set as your external port in your router. </br>

The server should automatically force users to download whatever mods the server has loaded. </br>

Have fun! </br>
