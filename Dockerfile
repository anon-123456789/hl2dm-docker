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
ADD health.sh splash.txt mount.cfg /


RUN \
    # Install healthcheck dependencies
    apt-get update \
    && apt upgrade -y \
    && apt-get install -y --no-install-recommends --no-install-suggests \
        net-tools \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* \
    # Make scripts executable
    && chmod -R +x /scripts/*.sh /*.sh \
    # Create mount directory
    && mkdir /mount \
    && chown steam:steam /mount


HEALTHCHECK CMD [ "/health.sh" ]
VOLUME [ "/mount" ]
