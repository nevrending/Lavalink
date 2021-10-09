FROM azul/zulu-openjdk:16

ARG HEAP=2G
ENV HEAP=$HEAP

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Run as non-root user
RUN groupadd -g 322 lavalink && \
    useradd -r -u 322 -g lavalink lavalink
USER lavalink

WORKDIR /opt/Lavalink

RUN wget https://github.com/freyacodes/Lavalink/releases/latest/download/Lavalink.jar

ENTRYPOINT java -Djdk.tls.client.protocols=TLSv1.2,TLSv1.3 -Xmx${HEAP} -jar Lavalink.jar

