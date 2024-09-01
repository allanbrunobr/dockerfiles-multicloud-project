#!/bin/sh
set -e

vault server -dev -dev-root-token-id=root -dev-listen-address=0.0.0.0:8200 &

sleep 5

/vault/config/setup-vault.sh

exec tail -f /dev/null