#! /bin/bash
cat /splash.txt

# Install/update GMod
sudo -u gmod steamcmd +force_install_dir /server/ +login anonymous +app_update 4020 +quit

# Replace mount.cfg
cp /mount.cfg /server/garrysmod/cfg/mount.cfg

# Setup permissions
usermod -u ${PUID} gmod
groupmod -g ${PGID} gmod
chown -R gmod:gmod /server /mount

# Assemble arguments
if [ -n "$WORKSHOP_COLLECTION" ]
then
    ARGS="+host_workshop_collection $WORKSHOP_COLLECTION $ARGS"
fi

ARGS="-strictportbind -port 27015 -game garrysmod -maxplayers ${MAX_PLAYERS} +gamemode ${GAME_MODE} +map ${MAP} ${ARGS}"

# Shed permissions down to a regular user and start the server
sudo -u gmod /server/srcds_run $ARGS
