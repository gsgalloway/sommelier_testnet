FROM alpine AS build-env

ARG SOMMELIER_VERSION=0.1.7
ARG GRAVITY_BRIDGE_VERSION=v0.1.14

RUN mkdir /install && \
    cd /install && \
    wget https://github.com/PeggyJV/sommelier/releases/download/v${SOMMELIER_VERSION}/sommelier_${SOMMELIER_VERSION}_linux_amd64.tar.gz && \
    tar -xf sommelier_${SOMMELIER_VERSION}_linux_amd64.tar.gz && \
    wget https://github.com/PeggyJV/gravity-bridge/releases/download/${GRAVITY_BRIDGE_VERSION}/client https://github.com/PeggyJV/gravity-bridge/releases/download/${GRAVITY_BRIDGE_VERSION}/contract-deployer https://github.com/PeggyJV/gravity-bridge/releases/download/${GRAVITY_BRIDGE_VERSION}/orchestrator https://github.com/PeggyJV/gravity-bridge/releases/download/${GRAVITY_BRIDGE_VERSION}/relayer https://github.com/PeggyJV/gravity-bridge/releases/download/${GRAVITY_BRIDGE_VERSION}/gorc && \
    chmod +x * && \
    cd / && \
    wget https://raw.githubusercontent.com/PeggyJV/sommelier/main/contrib/testnets/sommtest-3/genesis.json

FROM --platform=linux/amd64 ubuntu 

COPY --from=build-env /genesis.json /root/.sommelier/config/genesis.json

COPY --from=build-env /install/sommelier /install/client /install/contract-deployer /install/orchestrator /install/relayer /install/gorc /usr/bin/

COPY app.toml config.toml priv_validator_key.json /root/.sommelier/config/

COPY run.sh create_validator.sh /

EXPOSE 9090

ENTRYPOINT /run.sh
