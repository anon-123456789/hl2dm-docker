#! /bin/sh
usermod -u ${PUID} steam
groupmod -g ${PGID} steam
chown steam:steam /server
chown steam:steam /mount