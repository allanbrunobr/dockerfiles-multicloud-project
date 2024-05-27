#!/bin/sh
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN=root

# Wait for Vault to be ready
until vault status; do
  >&2 echo "Vault is unavailable - sleeping"
  sleep 1
done

# Write policy to Vault
vault policy write providers-policy providers-policy.hcl

# Store AWS secrets
vault kv put secret/aws access_key_id=AKIAVRUVTFYROQ5MQ3CG secret_access_key=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

# Store Azure secrets
vault kv put secret/azure client_id=22ba032b-0cd7-4920-9677-1767839d8420 client_secret=2_U8Q~1CJNJ7XAzjRUXUbLQiWCrtVDDf2faHRaZ~ tenant_id=9f091ec7-cb56-407d-8aff-3af3a6f6878e

# Store GCP secret (assuming the JSON content is stored in a file named gcp_secret.json)
vault kv put secret/gcp @gcp_secret.json
