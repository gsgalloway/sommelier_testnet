#!/usr/bin/env sh
set -u
set -e

sed -i s/NODE_MONIKER_PLACEHOLDER/$COSMOS_NODE_MONIKER/g $HOME/.sommelier/config/config.toml

set +e
echo "$COSMOS_VALIDATOR_KEYRING_PASSPHRASE" | sommelier keys delete validator -y 2>/dev/null
set -e

echo "$COSMOS_VALIDATOR_MNEMONIC
$COSMOS_VALIDATOR_KEYRING_PASSPHRASE
$COSMOS_VALIDATOR_KEYRING_PASSPHRASE" | sommelier keys add validator --recover

sommelier start --db_dir /sommelier-data
