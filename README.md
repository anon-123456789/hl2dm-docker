# GMod-Docker

### Forked from https://github.com/randomman552/GMod-Docker for my own use.

GMod (64-bit) dedicated server in a Docker container.\
Includes Counter-Strike: Source content and auto updates on restart

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
| REPLACE_MOUNT_CONFIG | true | Controls whether the `mount.cfg` file is replaced automatically on startup, set to any other value to disable |
| MAX_PLAYERS | 32 | Max players to allow |
| GAME_MODE | sandbox | Game mode to host |
| MAP | gm_construct | Map to host |
| WORKSHOP_COLLECTION | | Workshop collection to host, should be an ID like 2036327578 |
| LOCATION | | Server location, same as `sv_location` |
| PASSWORD | | Server password, same as `sv_password` |
| LOGIN_TOKEN | | Steam Game Server Login Token (GSLT), same as `+sv_setsteamaccount` |
| ARGS | | Any further arguments to pass|