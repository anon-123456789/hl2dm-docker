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

# Allow anyone to read/write to /home/gmod/.steam so any user can run the server
RUN mkdir ${HOME}/.steam \
    && chmod -R 777 ${HOME}

VOLUME [ "/server", "/mount" ]
ENTRYPOINT [ "/entrypoint.sh" ]