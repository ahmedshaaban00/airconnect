#!/bin/bash

# Exit script if you try to use an uninitialized variable.
set -o nounset

# Exit script if a statement returns a non-true return value.
set -o errexit

AIRPODS_NAME="Med’s AirPods"
BLUEUTIL_COMMAND=$(command -v blueutil)

if [ -z "$BLUEUTIL_COMMAND" ]; then
	brew install blueutil
fi

# Get Airpods Address
AIRPODS_ADDRESS=$(blueutil --paired --format json | jq --raw-output ".[] | select(.name == (\"$AIRPODS_NAME\")) | .address")

# Turn on bluetooth if it's turned off
if [ "$(blueutil --power)" == "0" ]; then
	blueutil --power 1
fi

blueutil --connect $AIRPODS_ADDRESS
echo "Connected to $AIRPODS_NAME."