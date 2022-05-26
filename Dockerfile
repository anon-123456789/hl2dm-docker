FROM ghcr.io/randomman552/steamcmd
ENV APP_ID=4020 START_CMD=/server/srcds_run
ENV PORT=27015 MAX_PLAYERS=32 GAME_MODE=sandbox MAP=gm_constuct WORKSHOP_COLLECTION= ARGS=

EXPOSE ${PORT}

# Add mount folder to store other servers to mount to this one
RUN mkdir /mount
RUN chown steam:steam /mount
VOLUME [ "/mount" ]

# Setup healthcheck
ADD healthcheck.sh /
RUN chmod -R +x /healthcheck.sh && apt-get install --no-install-recommends net-tools
HEALTHCHECK CMD [ "/healthcheck.sh" ]

# Copy scripts into container
ADD scripts/* /scripts/
ADD splash.txt mount.cfg /
ADD mount.cfg /
RUN chmod -R +x /scripts/*.sh
