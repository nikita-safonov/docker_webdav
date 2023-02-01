FROM nginx:latest

LABEL maintainer "nikita-safonov"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ARG UID=${UID:-1000}
ARG GID=${GID:-1000}

RUN \
    echo "**** change user UID and GID ****" && \
    usermod --uid $UID www-data && groupmod --gid $GID www-data && \
    echo "**** install nginx-extras ****" && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    nginx-extras && \
    echo "**** clean up ****" && \
    apt-get clean && \
    rm -rf \
      /config/* \
      /tmp/* \
      /var/lib/apt/lists/* \
      /var/tmp/* \
      /etc/nginx/sites-enabled/*

# add localfiles
COPY webdav.conf /etc/nginx/conf.d/default.conf
COPY entrypoint.sh /

# entrypoint
CMD /entrypoint.sh
