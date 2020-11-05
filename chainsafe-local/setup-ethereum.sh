#!/usr/bin/env bash

# Deploy the contracts on to the Ethereum chain
cb-sol-cli deploy --all --relayerThreshold 1

# Register fungible resource ID with erc20 contract
cb-sol-cli bridge register-resource --resourceId "0x000000000000000000000000000000c76ebe4a02bbc34786d860b355f5a5ce00" --targetContract "0x21605f71845f372A9ed84253d2D024B7B10999f4"

# Register the erc20 contract as mintable/burnable
cb-sol-cli bridge set-burn --tokenContract "0x21605f71845f372A9ed84253d2D024B7B10999f4"

# Register the associated handler as a minter
cb-sol-cli erc20 add-minter --minter "0x3167776db165D8eA0f51790CA2bbf44Db5105ADF"

#-----------------------------------------------------------------------------------

# Mint some tokens
cb-sol-cli erc20 mint --amount 1000

# Before initiating the transfer we have to approve the bridge to take ownership of the tokens
cb-sol-cli erc20 approve --amount 1000 --recipient "0x3167776db165D8eA0f51790CA2bbf44Db5105ADF"
