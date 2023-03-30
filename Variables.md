| Variable | Options | Default | Details
|:-|:-|:-|:-|
VERSION | `string` | `latest` | Sets the version of TML that the script will download. I recommend setting it to a value so it doesn't change upon new runs. `latest` will download the latest version on every initial run. Valid versions are in the releases [here](https://github.com/tModLoader/tModLoader/releases). Do not included the v letter in the string. <br><b>Note: The latest github version doesn't always support the latest client version.</b></br>
SERVERCONFIG | `boolean` | `0` | Toggles whether the server will use a user provided serverconfig file. `0` to use environment variables and `1` for provided file. 

Check out server details and examples [here on the wiki](https://terraria.fandom.com/wiki/Server#Server_config_file). </br>

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
PORT | `number` | `7777`
PRIORITY | `0` `1` `2` `3` `4` `5` | `1`
SECURE | `boolean` | `1`
SEED | `string` | `NA`
UPNP | `boolean` | `0`
WORLDNAME | `string` | `World`

Journey mode variables are not supported in the Dockerfile variable statements. Those will need to be manually put in the server config. </br>

Boolean values are either on (1) or off (0) </br>
Strings are anything you want to put in it. </br>
Numbers are simply just numbers with no spaces </br>