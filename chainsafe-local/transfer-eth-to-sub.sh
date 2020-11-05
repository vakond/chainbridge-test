#!/usr/bin/env bash

# If necessary, mint some tokens
#cb-sol-cli erc20 mint --amount 1000

# Before initiating the transfer we have to approve the bridge to take ownership of the tokens
#cb-sol-cli erc20 approve --amount 1000 --recipient "0x3167776db165D8eA0f51790CA2bbf44Db5105ADF"

# Initiate a transfer (Note: there will be a 10 block delay before the relayer will process the transfer)
cb-sol-cli erc20 deposit --amount 2 --dest 1 --recipient "0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d" --resourceId "0x000000000000000000000000000000c76ebe4a02bbc34786d860b355f5a5ce00"
