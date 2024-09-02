FROM hashicorp/vault:1.17.2

# cloud
# ENV VAULT_ADDR='http://0.0.0.0:8200' 
ENV VAULT_ADDR='http://127.0.0.1:8200'

# Criar diretórios necessários
RUN mkdir -p /vault/logs /vault/file /vault/config

#COPY ["providers-policy.hcl", "gcp_secret.json", "setup-vault.sh", "aws_policy_role_iam.json", "gcp_access_policy.hcl", "docker-entrypoint.sh", "/vault/config/"]

# Copiar arquivos de configuração (cloud)
COPY ["providers-policy.hcl", "setup-vault.sh", "aws_policy_role_iam.json", "gcp_access_policy.hcl", "docker-entrypoint.sh", "/vault/config/"]


RUN chmod +x /vault/config/setup-vault.sh /vault/config/docker-entrypoint.sh && \
    chown -R vault:vault /vault/logs /vault/file /vault/config

VOLUME ["/vault/logs", "/vault/file", "/vault/config"]

EXPOSE 8200

RUN mv /vault/config/docker-entrypoint.sh /usr/local/bin/

#cloud
# RUN chmod +x /usr/local/bin/docker-entrypoint.sh /usr/local/bin/setup-vault.sh 

#&& \
#   chown -R vault:vault /vault/logs /vault/file /vault/config


ENTRYPOINT ["docker-entrypoint.sh"]