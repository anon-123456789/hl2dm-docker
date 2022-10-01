# GMod-Docker
GMod dedicated server in a Debian based Docker container.\
Includes css content.

## File structure
The file structure within the container is as follows:
```
📁home/
├─ 📁steam/
│  ├─ 📜steamcmd.sh
📁mount/
├─ 📁css
📁server/
├─ Server files here
📁scripts/
├─ Scripts here
```

## Environment variables
Provides the following environment variables for configuration:
| Variable            | Default value | Description                                                  |
|:-------------------:|:-------------:|:------------------------------------------------------------:|
| PUID                | 1000          | ID of user SteamCMD and the server will be run as            |
| PGID                | 1000          | ID of group SteamCMD and the server will be run as           |
| VALIDATE            | true          | Whether to validate on game install                          |
| MAX_PLAYERS         | 32            | Max players to allow                                         |
| GAME_MODE           | sandbox       | Game mode to host                                            |
| MAP                 | gm_construct  | Map to host                                                  |
| PORT                | 27015         | Port to host one                                             |
| WORKSHOP_COLLECTION |               | Workshop collection to host, should be an ID like 2036327578 |
| ARGS                |               | Any further arguments to pass                                |

## Running
### Docker CLI
```sh
docker run \
    -p 27015:27015 \
    -v gmod:/server \
    -v gmod-mount:/mount \
    ghcr.io/randomman552/gmod
```
### Docker Compose
```yml
version: "3.8"
services:
    steamcmd:
        image: ghcr.io/randomman552/gmod
        ports:
            - 27015:27015
        volumes:
            - ./server:/server
            - ./mount:/mount
```
