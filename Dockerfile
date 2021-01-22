FROM lsiobase/alpine:3.12

LABEL maintainer="Griefed <griefed@griefed.de>"

ARG BOT_VERSION=1.2.3

RUN \
  echo "**** install dependencies and build tools and stuff ****" && \
  apk add --no-cache \
    openjdk11-jre-headless \
    curl && \
  echo "**** prepare environment ****" && \
    mkdir -p \
      /app/curseforgebot && \
  echo "**** installing application ****" && \
    curl -o \
      /app/curseforgebot/curseforgebot.jar -L \
        "https://github.com/ErdbeerbaerLP/Curseforge-Bot/releases/download/${BOT_VERSION}/Curseforge-Bot-${BOT_VERSION}.jar" && \
  echo "**** Cleanup ****" && \
    rm -rf \
      /root/.cache \
      /tmp/*

COPY root/ /

VOLUME /config