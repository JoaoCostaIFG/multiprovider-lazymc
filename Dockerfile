FROM openjdk:17-slim

EXPOSE 25565/tcp
EXPOSE 25565/udp

WORKDIR /data

RUN apt update && apt install -y curl wget

COPY run.sh /run.sh

ARG CPU_ARCHITECTURE=x64
ARG LAZYMC_VERSION=latest
RUN [ "$LAZYMC_VERSION" = "latest" ] && url="$(curl -s 'https://api.github.com/repos/timvisee/lazymc/releases/latest' | grep 'browser_' | cut -d\" -f4 | grep "\-${CPU_ARCHITECTURE}$")" || url="https://github.com/timvisee/lazymc/releases/download/v${LAZYMC_VERSION}/lazymc-v${LAZYMC_VERSION}-linux-${CPU_ARCHITECTURE}" && \
wget "$url" -qO /lazymc && chmod +x /lazymc

ARG MC_VERSION=1.19.3
RUN wget https://api.purpurmc.org/v2/purpur/${MC_VERSION}/latest/download -qO /purpur

ARG MC_RAM_MIN=512M
ARG MC_RAM_MAX=1G
ENV MC_RAM_MIN=${MC_RAM_MIN}
ENV MC_RAM_MAX=${MC_RAM_MAX}

ENTRYPOINT ["/run.sh"]

