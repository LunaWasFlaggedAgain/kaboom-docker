FROM openjdk:16-jdk-alpine

ARG AUTO_UPDATE
ARG MEMORY
ARG JAVA_OPTS
ENV AUTO_UPDATE=$AUTO_UPDATE
ENV MEMORY=$MEMORY
ENV JAVA_OPTS=$JAVA_OPTS

EXPOSE 25565/tcp
EXPOSE 19132/udp

COPY scripts /scripts
RUN chmod 555 /scripts -R
RUN apk add --update --no-cache bash git iptables

USER 1000:1000
VOLUME /server
WORKDIR /server

ENTRYPOINT ["/scripts/entrypoint.sh"]