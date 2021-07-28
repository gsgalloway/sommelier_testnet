#!/usr/bin/env sh
set -u
set -e

sed -i s/NODE_MONIKER_PLACEHOLDER/$COSMOS_NODE_MONIKER/g $HOME/.sommelier/config/config.toml

echo "$COSMOS_VALIDATOR_MNEMONIC
$COSMOS_VALIDATOR_KEYRING_PASSPHRASE
$COSMOS_VALIDATOR_KEYRING_PASSPHRASE" | sommelier keys add validator --recover

sommelier start --db_dir /sommelier-data
