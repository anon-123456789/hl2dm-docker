#! /bin/bash
cat /splash.txt

# Install/update CSS
echo "Installing CSS Server..."
steamcmd +force_install_dir /mount/css +login anonymous +app_update 232330 +quit
echo "Done!"

# Install/update GMod
echo "Installing GMod Server..."
steamcmd +force_install_dir /server/ +login anonymous +app_update 4020 +quit
echo "Done!"

# Replace mount.cfg
if [ "$REPLACE_MOUNT_CONFIG" = "true" ]; then
    echo "Replacing GMod mount.cfg..."
    cp /mount.cfg /server/garrysmod/cfg/mount.cfg
    echo "Done!"
fi

# Assemble arguments
if [ -n "$WORKSHOP_COLLECTION" ]
then
    ARGS="+host_workshop_collection $WORKSHOP_COLLECTION $ARGS"
fi

ARGS="-strictportbind -port 27015 -game garrysmod -maxplayers ${MAX_PLAYERS} +gamemode ${GAME_MODE} +map ${MAP} ${ARGS}"

# Start the server
echo "Starting server..."
/server/srcds_run $ARGS
echo "Finished!"
