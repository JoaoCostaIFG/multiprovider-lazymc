FROM openjdk:17-slim

EXPOSE 25565/tcp
EXPOSE 25565/udp

WORKDIR /data

RUN apt update && apt install -y curl wget

COPY . /

ARG CPU_ARCHITECTURE=x64 LAZYMC_VERSION=latest
ENV CPU_ARCHITECTURE=${CPU_ARCHITECTURE} LAZYMC_VERSION=${LAZYMC_VERSION}
RUN /install_lazymc.sh

ARG MC_VERSION=1.19.3
RUN wget https://api.purpurmc.org/v2/purpur/${MC_VERSION}/latest/download -qO /purpur

ENTRYPOINT ["/run.sh"]

