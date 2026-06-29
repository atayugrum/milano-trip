#!/bin/bash
# Builds index.html from milano-trip.html by injecting GMAPS_KEY.
# Local use: reads .env (gitignored). CI use: pass GMAPS_KEY as an env var.
set -e
cd "$(dirname "$0")"

if [ -z "$GMAPS_KEY" ] && [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

if [ -z "$GMAPS_KEY" ]; then
  echo "GMAPS_KEY not set (checked env and .env)" >&2
  exit 1
fi

sed "s/__GMAPS_KEY__/$GMAPS_KEY/g" milano-trip.html > index.html
echo "Built index.html"
