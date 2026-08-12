#!/bin/bash

stop() {
    echo "SIGTERM requested, Sending SIGINT to PID $SRCDS_RUN_PID..."
    kill -2 $SRCDS_RUN_PID
}

# Install/update HL2:DM
echo "Installing HL2:DM Server..."
steamcmd +force_install_dir /server +login anonymous +app_update 232370 -validate +quit
echo "Done!"

# Assemble arguments
if [ -n "$PASSWORD" ]
then
    ARGS="+sv_password $PASSWORD $ARGS"
fi

if [ -n "$LOGIN_TOKEN" ]
then
    ARGS="+sv_setsteamaccount $LOGIN_TOKEN $ARGS"
fi

ARGS="-strictportbind -port ${PORT:=27015} -game hl2mp -maxplayers ${MAX_PLAYERS} +map ${MAP} +sv_lan 0 ${ARGS}"

# Docker sends us a SIGTERM when the container stops, so trap it to actually shutdown the server cleanly
echo "Trapping SIGTERM..."
trap "stop" SIGTERM

# Start the server
echo "Starting server..."
/server/srcds_run $ARGS &
SRCDS_RUN_PID=$!
wait $SRCDS_RUN_PID
echo "Finished!"
