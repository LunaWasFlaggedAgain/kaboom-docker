FROM openjdk:16-jdk-alpine

COPY scripts /scripts
RUN chmod 555 /scripts /scripts/*
RUN apk add --no-cache bash

VOLUME /server
WORKDIR /server
USER 1000:1000

ARG AUTO_UPDATE
ARG MEMORY
ARG JAVA_OPTS
ENV AUTO_UPDATE=$AUTO_UPDATE
ENV MEMORY=$MEMORY
ENV JAVA_OPTS=$JAVA_OPTS

EXPOSE 25565/tcp
EXPOSE 19132/udp

HEALTHCHECK --interval=300s --timeout=30s --retries=1 CMD [ "/scripts/alivecheck.sh" ]
ENTRYPOINT ["/scripts/entrypoint.sh"]