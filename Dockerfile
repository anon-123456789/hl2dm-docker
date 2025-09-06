FROM docker.io/steamcmd/steamcmd:latest
ENV MAX_PLAYERS 32
ENV MAP dm_overwatch
ENV PASSWORD=
ENV LOGIN_TOKEN=
ENV ARGS=

WORKDIR /server

# Add files
COPY --chmod=755 entrypoint.sh /

VOLUME [ "/server" ]
ENTRYPOINT [ "/entrypoint.sh" ]