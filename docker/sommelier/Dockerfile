FROM alpine AS build-env

ARG SOMMELIER_VERSION=0.1.7

RUN mkdir /install && \
    cd /install && \
    wget https://github.com/PeggyJV/sommelier/releases/download/v${SOMMELIER_VERSION}/sommelier_${SOMMELIER_VERSION}_linux_amd64.tar.gz && \
    tar -xf sommelier_${SOMMELIER_VERSION}_linux_amd64.tar.gz && \
    wget https://raw.githubusercontent.com/PeggyJV/sommelier/main/contrib/testnets/sommtest-3/genesis.json

from --platform=linux/amd64 ubuntu 

COPY --from=build-env /install/sommelier /usr/bin/sommelier

COPY --from=build-env /install/genesis.json /root/.sommelier/config/genesis.json

COPY app.toml config.toml /root/.sommelier/config/

COPY run.sh /run.sh

ENTRYPOINT /run.sh
