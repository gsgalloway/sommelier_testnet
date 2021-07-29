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
    cosmosvaloper1l8apdh608ngu8y4urp57sttak6y8sp7xrrcgek \ # validator address
    cosmos1n3hzetkel90qyfh4jyvfp4llhscamw2n7c994d \
    $(gorc --config $HOME/gorc/config.toml keys eth show signer) \ # eth signer address
    $(gorc --config $HOME/gorc/config.toml sign-delegate-keys signer cosmosvaloper1l8apdh608ngu8y4urp57sttak6y8sp7xrrcgek) \ 
    --chain-id sommtest-3 \ 
    --from validator \ 
    --fees 25000usomm -y
