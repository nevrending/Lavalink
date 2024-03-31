FROM azul/zulu-openjdk:21

LABEL maintainer="Yefta Sutanto <yeftasutanto@gmail.com>"
LABEL org.opencontainers.image.source=https://github.com/nevrending/Lavalink

ARG VERSION=b0db58a0
ARG HEAP=2G
ENV HEAP=$HEAP

# RUN rm /etc/apt/sources.list.d/zulu-openjdk.list

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y axel net-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Run as non-root user
RUN groupadd -g 322 lavalink && \
    useradd -r -u 322 -g lavalink lavalink
USER lavalink

WORKDIR /opt/Lavalink

## stable
# RUN axel https://github.com/freyacodes/Lavalink/releases/latest/download/Lavalink.jar
## dev
# RUN axel https://ci.fredboat.com/guestAuth/repository/download/Lavalink_Build/.lastSuccessful/Lavalink.jar?branch=refs%2Fheads%2Fdev -o Lavalink.jar
# RUN axel -o Lavalink.jar https://github.com/freyacodes/Lavalink/releases/download/${VERSION}/Lavalink.jar
# hotfix 31 Mar 2024
RUN axel -o Lavalink.jar https://repo.lavalink.dev/artifacts/lavalink/b0db58a0/Lavalink.jar

COPY application.yml application.yml

ENTRYPOINT java -Djdk.tls.client.protocols=TLSv1.2,TLSv1.3 -Xmx${HEAP} -jar Lavalink.jar
