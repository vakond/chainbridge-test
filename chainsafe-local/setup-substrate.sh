#!/usr/bin/env bash

echo 'Make sure these settings are in https://polkadot.js.org/apps/?rpc=ws://127.0.0.1:9944#/settings/developer:'
cat <<SETTINGS
{
  "chainBridge::ChainId": "u8",
  "ChainId": "u8",
  "ResourceId": "[u8; 32]",
  "DepositNonce": "u64",
  "ProposalVotes": {
    "votes_for": "Vec<AccountId>",
    "votes_against": "Vec<AccountId>",
    "status": "u8",
    "expiry": "U256"
  },
  "TokenId": "U256",
  "Address": "AccountId",
  "LookupSource": "AccountId",
  "Erc721Token": {
    "Id": "U256",
    "Metadata": "Vec<u8>"
  },
  "Weight": "u32"
}
SETTINGS
echo 'Taken from here: https://gist.github.com/ansermino/0280b30594a9bc653ae288ccca46dc55'

echo
echo 'Registering Relayers'
echo 'First we need to register the account of the relayer on substrate (cb-sol-cli deploys contracts with the 5 test keys preloaded).'
echo '==> Select the Sudo tab in the PolkadotJS UI. Choose the addRelayer method of chainBridge, and select Alice as the relayer.'

echo
echo 'Register Resources'
echo '==> Select the Sudo tab and call chainBridge.setResourceId for each of the transfer types you wish to use:'
echo 'Fungible (Native asset):'
echo 'Id: 0x000000000000000000000000000000c76ebe4a02bbc34786d860b355f5a5ce00'
echo 'Method: 0x4578616d706c652e7472616e73666572 (utf-8 encoding of "Example.transfer")'

echo
echo 'Whitelist Chains'
echo '==> Using the Sudo tab, call chainBridge.whitelistChain, specifying 0 for out ethereum chain ID.'
