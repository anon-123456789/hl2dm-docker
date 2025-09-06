# GMod-Docker

### Forked from https://github.com/randomman552/GMod-Docker for my own use.

GMod dedicated server in an Ubuntu 22 Docker container.\
Includes css content and auto update's on restart

This is a rootless container, by default it runs as user `1000:1000` but this can be changed using the docker `user` option

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
| Variable             | Default value | Description                                                                                                   |
|:--------------------:|:-------------:|:-------------------------------------------------------------------------------------------------------------:|
| REPLACE_MOUNT_CONFIG | true          | Controls whether the `mount.cfg` file is replaced automatically on startup, set to any other value to disable |
| MAX_PLAYERS          | 32            | Max players to allow                                                                                          |
| GAME_MODE            | sandbox       | Game mode to host                                                                                             |
| MAP                  | gm_construct  | Map to host                                                                                                   |
| WORKSHOP_COLLECTION  |               | Workshop collection to host, should be an ID like 2036327578                                                  |
| ARGS                 |               | Any further arguments to pass                                                                                 |

## Running
### Docker CLI
```sh
docker run \
    -p 27015:27015 \
    -p 27015:27015/udp \
    -v gmod-server:/server \
    -v gmod-mount:/mount \
    randomman552/gmod
```

### Docker Compose
```yml
version: "3"
services:
    steamcmd:
        user: 1100:1100
        image: randomman552/gmod
        ports:
            - 27015:27015
            - 27015:27015/udp
        volumes:
            - ./server:/server
            - ./mount:/mount
```
