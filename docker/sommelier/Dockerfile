FROM alpine AS build-env

ARG SOMMELIER_VERSION=0.1.8
ARG GRAVITY_BRIDGE_VERSION=v0.1.21

RUN mkdir /install && \
    cd /install && \
    wget https://github.com/PeggyJV/sommelier/releases/download/v${SOMMELIER_VERSION}/sommelier_${SOMMELIER_VERSION}_linux_amd64.tar.gz && \
    tar -xf sommelier_${SOMMELIER_VERSION}_linux_amd64.tar.gz && \
    wget https://github.com/PeggyJV/gravity-bridge/releases/download/${GRAVITY_BRIDGE_VERSION}/contract-deployer https://github.com/PeggyJV/gravity-bridge/releases/download/${GRAVITY_BRIDGE_VERSION}/orchestrator https://github.com/PeggyJV/gravity-bridge/releases/download/${GRAVITY_BRIDGE_VERSION}/relayer https://github.com/PeggyJV/gravity-bridge/releases/download/${GRAVITY_BRIDGE_VERSION}/gorc && \
    chmod +x * && \
    cd / && \
    wget https://raw.githubusercontent.com/PeggyJV/sommelier/main/contrib/testnets/sommtest-4/genesis.json

FROM --platform=linux/amd64 ubuntu

RUN apt-get update && \
    apt-get install -y expect

COPY --from=build-env /genesis.json /root/.sommelier/config/genesis.json

COPY --from=build-env /install/sommelier /install/contract-deployer /install/orchestrator /install/relayer /install/gorc /usr/bin/

COPY app.toml config.toml priv_validator_key.json /root/.sommelier/config/

COPY run.sh create_validator.sh add_validator.exp /

EXPOSE 9090

ENTRYPOINT /run.sh
