FROM ghcr.io/randomman552/steamcmd
ENV APP_ID=4020 START_CMD=/server/srcds_run

LABEL org.opencontainers.image.source 'https://github.com/randomman552/GMod-Docker'
LABEL org.opencontainers.image.url 'https://github.com/randomman552/GMod-Docker'
LABEL org.opencontainers.image.documentation 'https://github.com/randomman552/GMod-Docker/blob/main/README.MD'
LABEL org.opencontainers.image.title 'GMod docker container'

# Copy scripts into container
ADD scripts/* /scripts/
RUN chmod -R +x /scripts
