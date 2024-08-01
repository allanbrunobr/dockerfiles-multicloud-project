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

vault kv put secret/gcp google_api_key_places=AIzaSyBMnDHDoSUU1t1DqEXWiF7FheEeMKHNm5A

#vault kv put secret/azure client_id=22ba032b-0cd7-4920-9677-1767839d8420 client_secret=2_U8Q~1CJNJ7XAzjRUXUbLQiWCrtVDDf2faHRaZ~ tenant_id=9f091ec7-cb56-407d-8aff-3af3a6f6878e


#AWS
vault secrets enable -path=aws aws


vault write aws/config/root \
   access_key=AKIAVRUVTFYRFH6X64V7 \
   secret_key=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 \
   region=default

policy_document=$(cat /vault/config/aws_policy_role_iam.json)

#SEM security_token
vault write aws/roles/my-role \
    credential_type=iam_user \
    policy_document="${policy_document}"

# vault write aws/roles/my-role \
#     credential_type=assumed_role \
#     policy_document="${policy_document}" \
#     role_arns=arn:aws:iam::381492080162:role/iam-adm-ecore \
#     ttl=1h



# GCP
vault secrets enable gcp

vault write gcp/config credentials=@gcp_secret.json

vault write gcp/roleset/my-key-roleset \
    project="app-springboot-project" \
    secret_type="service_account_key"  \
    bindings=@gcp_access_policy.hcl
