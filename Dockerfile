FROM steamcmd/steamcmd:ubuntu-22
ENV PUID 1000
ENV PGID 1000
ENV HOME /home/gmod
ENV MAX_PLAYERS 32
ENV GAME_MODE sandbox
ENV MAP gm_construct
ENV WORKSHOP_COLLECTION=
ENV ARGS=

EXPOSE 27015 27015/udp
WORKDIR /server

# Add normal user to run server under
RUN useradd -m gmod

# Install CSS content
RUN mkdir /mount && chown gmod:gmod /mount
USER gmod
RUN steamcmd +force_install_dir /mount/css +login anonymous +app_update 232330 +quit
USER root

# Install dependencies
RUN apt update && \
    apt install --no-install-recommends --no-install-suggests -y sudo iproute2 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Add files
ADD entrypoint.sh splash.txt mount.cfg /
RUN chmod -R +x /entrypoint.sh

VOLUME [ "/server" ]
HEALTHCHECK --interval=10s --start-period=30s --retries=3 CMD [ "if ! $(ss -l | grep LISTEN.*27015) 2> /dev/null ; then echo yes; fi" ]
ENTRYPOINT [ "/entrypoint.sh" ]