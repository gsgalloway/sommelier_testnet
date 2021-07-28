#!/usr/bin/env bash
set -u
set -e

: "$COSMOS_ORCHESTRATOR_MNEMONIC"
: "$ETH_SIGNER_PRIV_KEY"
: "$ETH_RPC_HOST"
: "$COSMOS_GRPC_HOST"

CONFIG_FILE=$HOME/gorc/config.toml

# pass the geth and cosmos RPC hosts through from env vars into the config file
sed -i s/ETH_RPC_HOST_PLACEHOLDER/$ETH_RPC_HOST/g $CONFIG_FILE
sed -i s/COSMOS_GRPC_HOST_PLACEHOLDER/$COSMOS_GRPC_HOST/g $CONFIG_FILE

./wait-for-it.sh -t 0 "$COSMOS_GRPC_HOST"
./wait-for-it.sh -t 0 "$ETH_RPC_HOST"

# restore orchestrator key with gorc
gorc --config $CONFIG_FILE keys cosmos recover orchestrator "$COSMOS_ORCHESTRATOR_MNEMONIC"

# restore eth priv key from metamask with gorc 
gorc --config $CONFIG_FILE keys eth import signer "$ETH_SIGNER_PRIV_KEY"

# run gorc
gorc --config $CONFIG_FILE orchestrator start --cosmos-key orchestrator --ethereum-key signer
