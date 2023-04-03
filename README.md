# tmodloader1.4-docker </br>

[![Repo](https://img.shields.io/badge/Docker-Repo-007EC6?labelColor-555555&color-007EC6&logo=docker&logoColor=fff&style=flat-square)](https://hub.docker.com/r/passivelemon/tmodloader1.4-docker)
[![Version](https://img.shields.io/docker/v/passivelemon/tmodloader1.4-docker/latest?labelColor-555555&color-007EC6&style=flat-square)](https://hub.docker.com/r/passivelemon/tmodloader1.4-docker)
[![Size](https://img.shields.io/docker/image-size/passivelemon/tmodloader1.4-docker/latest?sort=semver&labelColor-555555&color-007EC6&style=flat-square)](https://hub.docker.com/r/passivelemon/tmodloader1.4-docker)
[![Pulls](https://img.shields.io/docker/pulls/passivelemon/tmodloader1.4-docker?labelColor-555555&color-007EC6&style=flat-square)](https://hub.docker.com/r/passivelemon/tmodloader1.4-docker)

### Docker container </br>
```
docker run -d --name (container name) -p 7777:7777 -v (path to config files):/tmodloader/config/ -e VERSION=(tml version) passivelemon/tmodloader1.4-docker:latest
```
| Operator | Need | Details |
|:-|:-|:-|
| `-d` | Yes | will run the container in the background. |
| `--name (container name)` | No | Sets the name of the container to the following string. You can change this to whatever you want. |
| `-p 7777:7777` | Yes | The default port used by the server. This translates from your host 7777 into the container 7777. If you use a different port for your server in your serverconfig, change this. Make sure your serverconfig.txt accurately represents this. |
| `-v (path to config files):/tmodloader/config` | Yes | Sets the folder that holds the configs like your modpack, worlds, and serverconfig.txt. This should be the place you just chose. <br><b>THE SERVER WILL NOT RUN IF YOU DO NOT HAVE THIS</b>.</br> |
| `passivelemon/tmodloader1.4-docker:latest` | Yes | The repository on Docker hub. By default, it is the latest version that I have published. |

### Server environment variables: </br>
For every variable you want the server to use, add that variable to your docker run or compose with `-e (Variable name)=(Value)`. </br>
By default, the server will not successfully run. The only required variable for minimal functionality is `MODPACK`. You can find all of the valid server variables at in the [Variables.md](/Variables.md)

#### Example: </br>
```
docker run -d --name tmodloader1.4 -p 7777:7777/tcp -v /opt/tModLoaderServer/:/tmodloader/config/ -v /opt/tModLoaderServer/Logs/:/tmodloader/server/tModLoader-Logs/ -e MODPACK=ultimatepack -e WORLD=superworld -e VERSION=2022.09.47.33 passivelemon/tmodloader1.4-docker:latest
```
