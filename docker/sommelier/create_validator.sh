#!/usr/bin/env sh

set -e
set -u

sommelier tx staking create-validator \
  --amount=999999900000usomm \
  --pubkey=$(sommelier tendermint show-validator) \
  --moniker="$COSMOS_VALIDATOR_MONIKER" \
  --chain-id="sommtest-3" \
  --commission-rate="0.10" \
  --commission-max-rate="0.20" \
  --commission-max-change-rate="0.01" \
  --min-self-delegation="1000000" \
  --fees="100000usomm" \
  --from=validator

sommelier tx gravity set-delegate-keys \
    $(sommelier keys show validator --bech val -a) \ # validator address
    $(gorc --config $HOME/gorc/config.toml keys cosmos show orchestrator) \ # orchestrator address (this must be run manually and address extracted)
    $(gorc --config $HOME/gorc/config.toml keys eth show signer) \ # eth signer address
    $(gorc --config $HOME/gorc/config.toml sign-delegate-keys signer $(sommelier keys show validator --bech val -a)) \ 
    --chain-id sommtest-3 \ 
    --from validator \ 
    --fees 25000usomm -y
