FROM steamcmd/steamcmd:ubuntu-22
ENV HOME /home/gmod
ENV REPLACE_MOUNT_CONFIG true
ENV MAX_PLAYERS 32
ENV GAME_MODE sandbox
ENV MAP gm_construct
ENV WORKSHOP_COLLECTION=
ENV ARGS=

EXPOSE 27015 27015/udp
WORKDIR /server

# Add normal user to run server under
RUN useradd -m gmod

# Install dependencies
RUN apt update && \
    apt install --no-install-recommends --no-install-suggests -y sudo iproute2 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Create directories
RUN mkdir /mount && \
    chown gmod:gmod /mount /server

# Add files
COPY --chmod=755 --chown=gmod:gmod entrypoint.sh splash.txt mount.cfg /

# Allow anyone to read/write to /home/gmod/.steam so any user can run the server
RUN mkdir ${HOME}/.steam \
    && chown -R gmod:gmod ${HOME}/.steam \
    && chmod -R 777 ${HOME}

USER gmod

VOLUME [ "/server", "/mount" ]
HEALTHCHECK --interval=10s --start-period=30s --retries=3 CMD if [ $(ss -l | grep -c LISTEN.*27015) == "0" ] ; then exit 1; fi
ENTRYPOINT [ "/entrypoint.sh" ]