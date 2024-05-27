FROM vault:1.13.3

ENV VAULT_ADDR='http://127.0.0.1:8200'

# Run Vault server in development mode
CMD ["vault", "server", "-dev", "-dev-root-token-id=root", "-dev-listen-address=0.0.0.0:8200"]

# Use a script to perform additional setup after Vault has started
COPY providers-policy.hcl /docker-entrypoint-initdb.d/providers-policy.hcl
COPY gcp_secret.json /docker-entrypoint-initdb.d/gcp_secret.json
COPY setup-vault.sh /docker-entrypoint-initdb.d/setup-vault.sh


