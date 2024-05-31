#!/bin/sh
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN=root
export GOOGLE_APPLICATION_CREDENTIALS='/vault/config/gcp_secret.json' 

# Wait for Vault to be ready
until vault status; do
  >&2 echo "Vault is unavailable - sleeping"
  sleep 1
done

vault login $VAULT_TOKEN

vault policy write providers-policy /vault/config/providers-policy.hcl

#vault kv put secret/aws access_key_id=AKIAVRUVTFYROQ5MQ3CG secret_access_key=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

#vault kv put secret/azure client_id=22ba032b-0cd7-4920-9677-1767839d8420 client_secret=2_U8Q~1CJNJ7XAzjRUXUbLQiWCrtVDDf2faHRaZ~ tenant_id=9f091ec7-cb56-407d-8aff-3af3a6f6878e

#vault kv put secret/gcp @/vault/config/gcp_secret.json



#AWS
vault secrets enable -path=aws aws

 vault write aws/config/root \
   access_key=AKIAVRUVTFYRFH6X64V7 \
   secret_key=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 \
   region=default

policy_document=$(cat /vault/config/aws_policy_role_iam.json)

# GCP
#vault secrets enable gcpkms
vault secrets enable gcp

vault write gcp/config credentials=@gcp_secret.json

vault write gcp/static-account/my-token-account \
    service_account_email="sa-288@app-springboot-project.iam.gserviceaccount.com" \
    secret_type="access_token" \
    token_scopes="https://www.googleapis.com/auth/cloud-platform" \
    bindings=@gcp_access_policy.hcl