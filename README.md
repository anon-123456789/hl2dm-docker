# GMod-Docker
[![Build Status](https://drone.ggrainger.uk/api/badges/ggrainger/GMod/status.svg)](https://drone.ggrainger.uk/ggrainger/GMod)

GMod dedicated server in an Ubuntu 22 Docker container.\
Includes css content and auto update's on restart

Based on the [steamcmd](https://github.com/steamcmd/docker) Docker image

## File structure
The file structure within the container is as follows:
```
📁mount/
├─ 📁css
|  ├─ CSS content
📁server/
├─ Server files here
```

## Environment variables
Provides the following environment variables for configuration:
| Variable            | Default value | Description                                                  |
|:-------------------:|:-------------:|:------------------------------------------------------------:|
| PUID                | 1000          | ID of user SteamCMD and the server will be run as            |
| PGID                | 1000          | ID of group SteamCMD and the server will be run as           |
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
    -p 27015:27015/udp \
    -v gmod:/server \
    gitlab.ggrainger.uk/ggrainger/gmod-docker
```

### Docker Compose
```yml
version: "3"
services:
    steamcmd:
        image: gitlab.ggrainger.uk/ggrainger/gmod-docker
        ports:
            - 27015:27015
            - 27015:27015/udp
        volumes:
            - ./server:/server
```
