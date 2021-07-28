FROM alpine:latest as build-dev

ARG GRAVITY_BRIDGE_VERSION=v0.1.14

RUN mkdir install && \
        cd install && \
        wget https://github.com/PeggyJV/gravity-bridge/releases/download/${GRAVITY_BRIDGE_VERSION}/client https://github.com/PeggyJV/gravity-bridge/releases/download/${GRAVITY_BRIDGE_VERSION}/contract-deployer https://github.com/PeggyJV/gravity-bridge/releases/download/${GRAVITY_BRIDGE_VERSION}/orchestrator https://github.com/PeggyJV/gravity-bridge/releases/download/${GRAVITY_BRIDGE_VERSION}/relayer https://github.com/PeggyJV/gravity-bridge/releases/download/${GRAVITY_BRIDGE_VERSION}/gorc && \
        chmod +x *

FROM alpine:latest

ENV RUST_LOG=INFO

COPY --from=build-dev /install/* /usr/bin/

COPY config.toml /root/gorc/config.toml

COPY run.sh /run.sh

ENTRYPOINT /run.sh
