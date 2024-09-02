FROM hashicorp/vault:1.17.2

ENV VAULT_ADDR='http://0.0.0.0:8200'

# Criar diretórios necessários
RUN mkdir -p /vault/logs /vault/file /vault/config

# Copiar arquivos de configuração
COPY ["providers-policy.hcl", "setup-vault.sh", "aws_policy_role_iam.json", "gcp_access_policy.hcl", "/vault/config/"]

# Dar permissões adequadas
RUN chmod +x /vault/config/setup-vault.sh && \
    chown -R vault:vault /vault/logs /vault/file /vault/config

# Declarar volumes
VOLUME ["/vault/logs", "/vault/file", "/vault/config"]

EXPOSE 8200

# Usar um script de inicialização
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]