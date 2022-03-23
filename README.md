# GMod-Docker
GMod dedicated server in a Debian based Docker container.

## File structure
The file structure within the container is as follows:
```
📁home/
├─ 📁steam/
│  ├─ 📜steamcmd.sh
📁server/
├─ server files here
📁scripts/
├─ 📜entrypoint.sh
├─ 📜fix_permissions.sh
├─ 📜install.sh
├─ 📜start.sh
```

If you wish to preserve the installed server between runs, you should create a volume or a bind mount for the `/server` directory.

## Environment variables
Provides the following environment variables for configuration:
| Variable  | Default value | Description                                        |
|:---------:|:-------------:|:--------------------------------------------------:|
| PUID      | 1000          | ID of user SteamCMD and the server will be run as  |
| PGID      | 1000          | ID of group SteamCMD and the server will be run as |

## Running
### Docker CLI
```sh
docker run \
    -p 27015:27015 \
    -v gmod:/server \
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
```
