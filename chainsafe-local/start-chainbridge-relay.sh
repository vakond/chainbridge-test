#!/usr/bin/env bash

# Start relayer using the default "Alice" key

chainbridge --config config.json --latest --testkey alice --verbosity trce
