FROM ghcr.io/randomman552/steamcmd
ENV APP_ID=4020 \
    START_CMD=/server/srcds_run \
    PORT=27015 \
    MAX_PLAYERS=32 \
    GAME_MODE=sandbox \
    MAP=gm_constuct \
    WORKSHOP_COLLECTION= \
    ARGS=
EXPOSE ${PORT}


# Add files
ADD scripts/* /scripts/
ADD perms.sh splash.txt mount.cfg /


RUN \
    # +x to scripts
        chmod -R +x /scripts/*.sh /*.sh \
    # Create mount directory
        && mkdir /mount \
        && chown steam:steam /mount


VOLUME [ "/mount" ]
