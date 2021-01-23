FROM openjdk:15-jdk-alpine3.12 AS builder

RUN \
  apk add --no-cache \
    git && \
  git clone \
    https://github.com/ijo42/CurseForge2Discord.git \
      /tmp/curseforgebot

WORKDIR /tmp/curseforgebot

RUN \
  ./gradlew

FROM lsiobase/ubuntu:bionic

LABEL maintainer="Griefed <griefed@griefed.de>"

RUN \
  echo "**** install dependencies and build tools and stuff ****" && \
  curl -o \
    /tmp/openjdk-15.tar.gz \
      "https://download.java.net/openjdk/jdk15/ri/openjdk-15+36_linux-x64_bin.tar.gz" && \
  mkdir -p \
    /usr/lib/jvm && \
  tar -xf \
    /tmp/openjdk-15.tar.gz -C \
       /usr/lib/jvm/ && \
  echo "JAVA_HOME=/usr/lib/jvm/jdk-15" >> /etc/profile && \
  echo "PATH=$PATH:$HOME/bin:$JAVA_HOME/bin" >> /etc/profile && \
  echo "export JAVA_HOME" >> /etc/profile && \
  echo "export JRE_HOME" >> /etc/profile && \
  echo "export PATH" >> /etc/profile && \
  mkdir -p \
    /app/curseforgebot

COPY --from=builder /build/libs/CurseForge2Discord-master.jar /app/curseforgebot/CurseForge2Discord.jar

RUN \
  echo "**** Cleanup ****" && \
    rm -rf \
      /root/.cache \
      /tmp/*

COPY root/ /

VOLUME /config