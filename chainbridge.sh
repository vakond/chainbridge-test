#!/bin/sh
# This script is intended to run in a container automatically.
# It's useless to try launch it out of that context.

/go/ChainBridge/cmd/chainbridge/chainbridge \
    --config ./config.json \
    --verbosity info \
    --testkey alice \
    --latest
