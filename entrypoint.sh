#!/bin/bash

stop() {
    echo "SIGTERM requested, looking for \"/tmp/server.pid\"..."
    if [ -e "/tmp/server.pid" ]; then
        echo "\"/tmp/server.pid\" exists, going to shutdown the server cleanly..."
        SERVER_PID=$(< "/tmp/server.pid")
        echo "Sending SIGINT to PID $SERVER_PID..."
        kill -2 $(< "/tmp/server.pid")
    else 
        echo "\"/tmp/server.pid\" doesn't exist, going to exit with code 1"
        exit 1
    fi
}

# Delete the PID file on startup
echo "Removing PID file \"/tmp/server.pid\"..."
rm -fv /tmp/server.pid

# Install/update CSS
echo "Installing CSS Server..."
steamcmd +force_install_dir /mount/css +login anonymous +app_update 232330 -validate +quit
echo "Done!"

# Install/update GMod
echo "Installing GMod Server..."
steamcmd +force_install_dir /server/ +login anonymous +app_update 4020 -beta x86-64 validate +quit
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

if [ -n "$LOCATION" ]
then
    ARGS="+sv_location $LOCATION $ARGS"
fi

if [ -n "$PASSWORD" ]
then
    ARGS="+sv_password $PASSWORD $ARGS"
fi

if [ -n "$LOGIN_TOKEN" ]
then
    ARGS="+sv_setsteamaccount $LOGIN_TOKEN $ARGS"
fi

ARGS="-pidfile /tmp/server.pid -strictportbind -port ${PORT:=27015} -game garrysmod -maxplayers ${MAX_PLAYERS} +gamemode ${GAME_MODE} +map ${MAP} +sv_lan 0 ${ARGS}"

# Docker sends us a SIGTERM when the container stops, so trap it to actually shutdown the server cleanly
echo "Trapping SIGTERM..."
trap "stop" SIGTERM

# Start the server
echo "Starting server..."
/server/srcds_run_x64 $ARGS &
wait $!
echo "Finished!"
