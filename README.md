# hl2dm-docker

### Forked from https://github.com/anon-123456789/gmod-docker, which was forked from https://github.com/randomman552/GMod-Docker for my own use.
> [!IMPORTANT]
> This server runs as root by default because I use Docker in rootless mode. If you are using the default rootful mode, this may pose a security risk to your system.

Half-Life 2: Deathmatch dedicated server in a Docker container.\
Includes auto updates on restart

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
| Variable | Default value | Description |
|:-----:|:-----:|-----:|
| PORT | 27015 | Server port |
| MAX_PLAYERS | 32 | Max players to allow |
| MAP | dm_overwatch | Map to host |
| PASSWORD | | Server password, same as `sv_password` |
| LOGIN_TOKEN | | Steam Game Server Login Token (GSLT), same as `+sv_setsteamaccount` |
| ARGS | | Any further arguments to pass|