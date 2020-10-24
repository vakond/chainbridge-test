#!/usr/bin/env bash
# This script is intended to run in a container automatically.
# It would be useless to try launch it out of that context.

# Exit on failure
set -e

# Turn on job control
set -m

HOST=0.0.0.0 # listen all addresses to work in a container properly
PORT=8545

geth version

echo "Starting ganache..."
/root/node_modules/.bin/ganache-cli --blockTime 0.1 \
	    --gasLimit 60000000 \
	    --host $HOST \
	    --port $PORT \
	    --account "0x000000000000000000000000000000000000000000000000000000616c696365,100000000000000000000" \
	    --account "0x0000000000000000000000000000000000000000000000000000000000626f62,100000000000000000000" \
	    --account "0x00000000000000000000000000000000000000000000000000636861726c6965,100000000000000000000" \
	    --account "0x0000000000000000000000000000000000000000000000000000000064617665,100000000000000000000" \
	    --account "0x0000000000000000000000000000000000000000000000000000000000657665,100000000000000000000" &

sleep 5

echo "Deploying all smart contracts..."
cb-sol-cli deploy --all --relayerThreshold 1

echo "Registering resource for ERC20..."
cb-sol-cli bridge register-resource \
	   --resourceId "0x000000000000000000000000000000c76ebe4a02bbc34786d860b355f5a5ce00" \
	   --targetContract "0x21605f71845f372A9ed84253d2D024B7B10999f4"

echo "Registering ERC20 as burnable..."
cb-sol-cli bridge set-burn \
	   --tokenContract "0x21605f71845f372A9ed84253d2D024B7B10999f4"

echo "Registering ERC20 as mintable..."
cb-sol-cli erc20 add-minter \
	   --minter "0x3167776db165D8eA0f51790CA2bbf44Db5105ADF"

echo "Minting tokens..."
cb-sol-cli erc20 mint --amount 1000000

echo "Approving bridge to receive tokens..."
cb-sol-cli erc20 approve --amount 1000000 \
	   --recipient "0x3167776db165D8eA0f51790CA2bbf44Db5105ADF"

echo
echo "Ganache listening on $HOST:$PORT..."
echo

fg %1
