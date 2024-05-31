FROM vault:1.13.3

ENV VAULT_ADDR='http://127.0.0.1:8200'

# Run Vault server in development mode
CMD ["vault", "server", "-dev", "-dev-root-token-id=root", "-dev-listen-address=0.0.0.0:8200"]

# Use a script to perform additional setup after Vault has started
COPY providers-policy.hcl /vault/config/providers-policy.hcl
COPY gcp_secret.json /vault/config/gcp_secret.json
COPY setup-vault.sh /vault/config/setup-vault.sh
COPY aws_policy_role_iam.json /vault/config/aws_policy_role_iam.json
COPY gcp_access_policy.hcl /vault/config/gcp_access_policy.hcl

RUN chmod +x /vault/config/setup-vault.sh
