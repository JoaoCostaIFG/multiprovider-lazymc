FROM openjdk:17-slim

EXPOSE 25565/tcp
EXPOSE 25565/udp

WORKDIR /data

RUN groupadd --gid 25565 --system minecraft && \
  useradd --uid 25565 -g minecraft -s /sbin/nologin --system minecraft
RUN apt update && apt install -y curl jq

COPY . /

ARG CPU_ARCHITECTURE=x64 LAZYMC_VERSION=latest
ENV CPU_ARCHITECTURE=${CPU_ARCHITECTURE} LAZYMC_VERSION=${LAZYMC_VERSION}
RUN /install_lazymc.sh

ARG SERVER_PROVIDER=purpur MC_VERSION=1.19.3
ENV SERVER_PROVIDER=${SERVER_PROVIDER} MC_VERSION=${MC_VERSION}
RUN /install_server.sh

USER minecraft

ENTRYPOINT ["/run.sh"]

