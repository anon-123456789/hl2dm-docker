FROM docker.io/steamcmd/steamcmd:latest
ENV HOME /home/gmod
ENV REPLACE_MOUNT_CONFIG true
ENV MAX_PLAYERS 32
ENV GAME_MODE sandbox
ENV MAP gm_construct
ENV WORKSHOP_COLLECTION=
ENV LOCATION=
ENV PASSWORD=
ENV LOGIN_TOKEN=
ENV ARGS=

WORKDIR /server

# Create directories
RUN mkdir /mount

# Add files
COPY --chmod=755 entrypoint.sh splash.txt mount.cfg /

VOLUME [ "/server", "/mount" ]
ENTRYPOINT [ "/entrypoint.sh" ]