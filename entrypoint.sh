#!/bin/bash

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

# Start the server
echo "Starting server..."
/server/srcds_run $ARGS
echo "Finished!"
