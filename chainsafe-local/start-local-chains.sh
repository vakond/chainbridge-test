#!/usr/bin/env bash

# Start a geth instance and an instance of chainbridge-substrate-chain

docker-compose -f ./docker-compose-geth-substrate.yml up -V
