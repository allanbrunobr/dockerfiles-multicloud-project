#!/bin/sh
export VAULT_ADDR='http://0.0.0.0:8200'
export VAULT_TOKEN=root
export GOOGLE_APPLICATION_CREDENTIALS='/vault/config/gcp_secret.json' 

# Wait for Vault to be ready
until vault status; do
  >&2 echo "Vault is unavailable - sleeping"
  sleep 1
done

vault login $VAULT_TOKEN

vault policy write providers-policy /vault/config/providers-policy.hcl

vault kv put secret/gcp google_api_key_places=AIzaSyBMnDHDoSUU1t1DqEXWiF7FheEeMKHNm5A

#AWS
vault secrets enable -path=aws aws

vault write aws/config/root \
   access_key=AKIAVRUVTFYRFH6X64V7 \
   secret_key=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 \
   region=default

policy_document=$(cat /vault/config/aws_policy_role_iam.json)

vault write aws/roles/my-role \
    credential_type=iam_user \
    policy_document="${policy_document}"

# GCP
vault secrets enable gcp

vault write gcp/config credentials=@/vault/config/gcp_secret.json

vault write gcp/roleset/my-key-roleset \
    project="app-springboot-project" \
    secret_type="service_account_key"  \
    bindings=@/vault/config/gcp_access_policy.hcl