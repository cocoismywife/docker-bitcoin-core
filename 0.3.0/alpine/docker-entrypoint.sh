#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for omnicored"

  set -- omnicored "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "omnicored" ]; then
  mkdir -p "$OMNI_DATA"
  chmod 700 "$OMNI_DATA"
  chown -R omnicore "$OMNI_DATA"

  echo "$0: setting data directory to $OMNI_DATA"

  set -- "$@" -datadir="$OMNI_DATA"
fi

if [ "$1" = "omnicored" ] || [ "$1" = "omnicored-cli" ]; then
  echo
  exec su-exec omnicore "$@"
fi

echo
exec "$@"
