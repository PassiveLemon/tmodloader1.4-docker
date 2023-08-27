# [tmodloader1.4-docker](https://github.com/PassiveLemon/tmodloader1.4-docker) </br>

[![Repo](https://img.shields.io/badge/Docker-Repo-007EC6?labelColor-555555&color-007EC6&logo=docker&logoColor=fff&style=flat-square)](https://hub.docker.com/r/passivelemon/tmodloader1.4-docker)
[![Version](https://img.shields.io/docker/v/passivelemon/tmodloader1.4-docker/latest?labelColor-555555&color-007EC6&style=flat-square)](https://hub.docker.com/r/passivelemon/tmodloader1.4-docker)
[![Size](https://img.shields.io/docker/image-size/passivelemon/tmodloader1.4-docker/latest?labelColor-555555&color-007EC6&style=flat-square)](https://hub.docker.com/r/passivelemon/tmodloader1.4-docker)
[![Pulls](https://img.shields.io/docker/pulls/passivelemon/tmodloader1.4-docker?labelColor-555555&color-007EC6&style=flat-square)](https://hub.docker.com/r/passivelemon/tmodloader1.4-docker)

Docker container for a [tModLoader](https://github.com/tModLoader/tModLoader) 1.4 dedicated server </br>

Setup guide is also in the [Wiki](https://github.com/PassiveLemon/tmodloader1.4-docker/wiki) for organization. </br>

# Quick setup
1. Setup a directory for you server files. Can be something like `/opt/TerrariaServer/` or `C:\TerrariaServer\`.
2. Add your modpack to the previous directory in the sub-directory `ModPacks/`
3. Run the container: <b>(Make sure to modify any values that you need.)</b>
  - ```docker run -d --name tmodloader1.4 -p 7777:7777/tcp -v /opt/TerrariaServer/:/opt/tmodloader/config/ -e MODPACK=(your modpack) -e WORLD=superworld passivelemon/tmodloader1.4-docker:latest```
4. Set up port forwarding.

# 1. Setting up main server files
Depending on your host, find a suitable place to store your server files. Make sure it is empty, safe, and accessible. For example: On Windows, something like `C:\TerrariaServer\` or a Linux equivalent like `/opt/TerrariaServer/`. </br>

For the sake of these instructions, we will call this place `(ConfDir)`. In `(ConfDir)`, make 2 directories, one called `ModPacks` and one called `Worlds`, spelled exactly as show. This location is also where your `serverconfig.txt` will be stored if you want to use your own. Details on this are in step 5. </br>

# 2. Server environment variables
For every variable you want the server to use, add that variable to your docker run or compose with `-e (Variable)=(Value)`. If they are not set, they will default to whatever their default value is. This is to ensure basic functionality. By default, the server will not successfully run. The only server variable required to be set for the server to function is `MODPACK`.

### Container variables </br>
| Variable | Options | Default | Details
|:-|:-|:-|:-|
SERVERCONFIG | `boolean` | `0` | Toggles whether the server will use a user provided serverconfig file. `0` to use environment variables and `1` for provided file. 

Check out server details and examples [here on the wiki](https://terraria.fandom.com/wiki/Server#Server_config_file). </br>

### Server variables </br>
| Variable | Options | Default |
|:-|:-|:-|
AUTOCREATE | `1` `2` `3`| `2`
DIFFICULTY | `0` `1` `2` `3` | `0`
BANLIST | `string`| `banlist.txt`
LANGUAGE | `en-US` `de-DE` `it-IT` `fr-FR` `es-ES` `ru-RU` `zh-Hans` `pt-BR` `pl-PL` | `en-US`
MAXPLAYERS | `number` | `8`
MODPACK | `string` | `NA`
MOTD | `string` | `NA`
NPCSTREAM | `number 0-60` | `15`
PASSWORD | `string` | `NA`
PRIORITY | `0` `1` `2` `3` `4` `5` | `1`
SECURE | `boolean` | `1`
SEED | `string` | `NA`
UPNP | `boolean` | `0`
WORLDNAME | `string` | `World`
 - Note: The internal port is not changeable.

Journey mode variables are not supported in the Dockerfile variable statements. Those will need to be manually put in the server config. </br>

<br> Boolean values are either on (1) or off (0). </br>
<br> Strings are anything you want to put in it, as long as it is valid. </br>
<br> Numbers are simply just numbers with no spaces. These too have a functional limit. </br>

# 3. Modpacks
Ideally, you shouldn't include any client side only mods in the modpack folder for the server. Client side mods only affect the client (player) meaning they add zero new functionality to the game. Includes things like different textures, shaders, RPC, etc. Nothing bad should happen if you do but it's just best practice. Mods are included in the modpack folder so they do not need to be obtained manually. </br>

1. In tModLoader on your client, enable any mods that you want to play with. </br>
2. Go to the mod pack section. </br>
3. "Save Enabled as New Mod Pack" </br>
4. "Open Mod Pack folder" </br>
5. Copy the folder of the modpack you want to use in the server and paste that into `(ConfDir)/ModPacks/` </br>

Make sure the modpack has an `enabled.json` with the mods you want or else the server will not start. </br>

# 4. Worlds
<b> If you want to continue on an existing world, follow this step. Otherwise, just skip it. The server will generate a new world automatically.</b>

If you provide a world file and correctly set the `WORLDNAME` variable, it will use the existing world. Make sure that the mods used on the world are the same as the ones in your modpack or else you may risk some world corruption. </br>

1. Go to `C:\Users\(user)\Documents\My Games\Terraria\tModLoader\Worlds\` or the Linux equivalent, usually `/home/(user)/.local/share/Terraria/tModLoader/Worlds/`. </br>
2. Copy the files of the world of your choice to `(ConfDir)/Worlds/`. The world files look like `.wld` and `.twld`. </br>

# 5. Server config
<b> If you want to use your own server config, follow this step. Otherwise, just skip it. The server will generate a config automatically based on your provided environment variables. </b>

The root of the tmodloader server files in the container is `/opt/tmodloader/server/` and user items in `(ConfDir)` are mounted at `/opt/tmodloader/config/` </br>

1. Set `SERVERCONFIG` to 1. 
2. Put the `serverconfig.txt` into `(ConfDir)/`.

[Server configuration details on the Terraria Wiki](https://terraria.fandom.com/wiki/Server#Server_config_file) </br>

# 6. Docker container
### Docker run </br>
```
docker run -d --name (container name) -p 7777:7777 -v (ConfDir):/opt/tmodloader/config/ passivelemon/tmodloader1.4-docker:latest
```

### Docker Compose
```yml
version: '3.3'
services:
  tmodloader-docker:
    image: passivelemon/tmoadloader-docker:latest
    container_name: tmoadloader-docker
    ports:
        - 7777:7777
    volumes:
      - (configuration directory):/opt/tmodloader/
```

| Operator | Need | Details |
|:-|:-|:-|
| `-d` | Yes | Will run the container in the background. |
| `--name (container name)` | No | Sets the name of the container to the following string. You can change this to whatever you want. |
| `-p 7777:7777` | Yes | The default port used by the server. This translates from your host 7777 into the container 7777. <br><b>If you use a different port for your server in your serverconfig, change this.</b></br> |
| `-v (ConfDir):/opt/tmodloader/config` | Yes | Sets the folder that holds the configs like your modpack, worlds, and serverconfig.txt. This should be the place you just chose. |
| `passivelemon/tmodloader1.4-docker:latest` | Yes | The repository on Docker hub. By default, it is the latest version that I have published. |

| Tag | Purpose |
| :- | :- |
| `latest` | The latest tModLoader release. |
| `version-latest` | The latest release of that version. (2022, 2023) |
| `version-latest-pre` | The latest release of that pre-release. |

## Examples </br>
### Docker run
```
docker run -d --name tmodloader1.4 -p 7777:7777/tcp -v /opt/tModLoaderServer/:/opt/tmodloader/config/ -e MODPACK=ultimatepack -e WORLD=superworld passivelemon/tmodloader1.4-docker:latest
```

### Docker compose
```yml
version: '3.3'
services:
  tmodloader-docker:
    image: passivelemon/tmoadloader-docker:latest
    container_name: tmoadloader-docker
    ports:
      - 7777:7777
    volumes:
      - /opt/tModLoaderServer/:/opt/tmodloader/
    environment:
      MODPACK: 'ultimatepack'
      WORLD: 'superworld'
```

# 7. Port forwarding
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

# 8. Reference
Your config directory should look something like:
```
(ConfDir)\              - This gets mounted to /config/ in the container
    Logs\               - This is optional. Make sure to mount it.
    ModPacks\           - Default folder needed by the server
        my-modpack\     - The name of your modpack
    Worlds\             - Default folder needed by the server
    serverconfig.txt    - config file needed by the server (Only if you want to use your own)
```

# 9. The end
Assuming you did everything correctly, you should have a functional server that will automatically load the modpack and world upon start.</br>

Some mods might have issues with the server when it starts up. This is rare but it happens and I can not do anything about this so you will have to remove that mod or find a work around yourself. </br>

## Command injection
You can run the command `docker exec (container name or id) inject "phrase"` to inject a phrase or command directly into the server. An example: `docker exec terrariaserver inject "say I'm radioactive!"`

## Access </br>
In order to access the server, you will need the public IP of the host. This could be access from a properly setup CDN but you might not have one. In this case, search up "Whats my ip" or similar into your browser and use the IP that it shows.
- <b>NOTE:</b> It isn't recommended to use this as it gives users your general location. It may be the only option you have though so be careful. </br>

You will also need a port. If you didn't change the defaults, it will just be 7777. If you did change from defaults, it will be whatever port you set as your external port in your router. </br>

The server should automatically force users to download whatever mods the server has loaded. </br>

Have fun! </br>

## Other details
If you get a jq syntax error, you might be rate limited by GitHub. Try running `curl -s https://api.github.com/repos/tModLoader/tModLoader/releases` on the server host and check the message. </br>

If you have any issues, questions, or concerns, open an issue and I will offer support. </br>

# Credits
[rfvgyhn](https://github.com/rfvgyhn/tmodloader-docker) for the server injection functionality.
