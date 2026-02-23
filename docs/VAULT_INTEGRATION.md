# Deploy Standardized ESO ClusterSecretStore for Hashicorp Vault

This section demonstrates what is needed for deployment. Users can evaluate and adjust for their own environment.
Vault provides multiple authentication methods, the two most relevant for External Secrets are:

- **Token Authentication**: Static token to authenticate into Vault.
- **Kubernetes Authentication**: ESO authenticates to Vault using a Kubernetes service account JWT.

There are multiple types of authentication methods: token, approle, kubernetes, etc. Here we use the token method. See the [External Secrets Vault provider docs](https://external-secrets.io/latest/provider/hashicorp-vault/) for full details.

## Prerequisites

### Network and Istio Requirements

When deploying in a Big Bang environment with hardened Istio and NetworkPolicies, ESO needs network-level and service mesh-level access to Vault.

**Handled automatically by the ESO chart:**

- **Egress NetworkPolicy**: The ESO chart creates `allow-egress-vault` when `networkPolicies.enabled: true`, allowing ESO pods to reach the vault namespace on port 8200.
- **Ingress NetworkPolicy (vault-side)**: The ESO chart defaults the pod label `vault-ingress: "true"` on ESO pods. The BB Vault chart includes a NetworkPolicy (`allow-ingress-to-vault-port-8200-from-custom-app-ingress`) that allows ingress on port 8200 from any pod with this label.

**Required in your Vault configuration:**

The BB Vault chart deploys a deny-all Istio AuthorizationPolicy by default. You must add an ALLOW policy for the external-secrets namespace. Add the following to your Vault Big Bang override values:

```yaml
addons:
  vault:
    values:
      istio:
        hardened:
          customAuthorizationPolicies:
            - name: allow-external-secrets
              enabled: true
              spec:
                action: ALLOW
                rules:
                  - from:
                      - source:
                          namespaces:
                            - external-secrets
                    to:
                      - operation:
                          ports:
                            - "8200"
```

## Authentication Method: Token

### Create a Secret containing your Vault Token

This is needed for the token auth. Example below.

```bash
kubectl create secret generic vault-token -n external-secrets --from-literal=token='<VAULT_TOKEN>'
```

### Big Bang Override Values

```yaml
addons:
  externalSecrets:
    enabled: true
    values:
      networkPolicies:
        enabled: true
      clusterSecretStoreConfiguration:
        enabled: true
        clusterSecretStoreList:
          - name: vault-secrets
            source:
              provider: vault
              server: "https://vault.example.com:8200"
              path: kv
              version: v2
              auth:
                type: token
                secretName: vault-token
                namespace: external-secrets
                key: token
```

## Authentication Method: Kubernetes

Vault's Kubernetes authentication allows ESO to log in using a Kubernetes ServiceAccount. Vault verifies the SA's JWT with the Kubernetes API and issues a Vault token mapped to a Vault role.

Prerequisites:
- A Vault server accessible from the cluster
- Kubernetes auth path enabled and configured in Vault
- A Vault role bound to the ESO ServiceAccount

### Configure Vault

Enable Kubernetes Auth in Vault:

```bash
vault auth enable kubernetes
```

Use the `/config` endpoint to configure Vault to talk to Kubernetes. Use `kubectl cluster-info` to validate the Kubernetes host address and TCP port.

```bash
vault write auth/kubernetes/config \
    token_reviewer_jwt="<your reviewer service account JWT>" \
    kubernetes_host=https://192.168.99.100:<your TCP port or blank for 443> \
    kubernetes_ca_cert=@ca.crt
```

Create a named role:

```bash
vault write auth/kubernetes/role/eso-role \
    bound_service_account_names=external-secrets \
    bound_service_account_namespaces=external-secrets \
    policies=default \
    ttl=1h
```

### Big Bang Override Values

```yaml
addons:
  externalSecrets:
    enabled: true
    values:
      networkPolicies:
        enabled: true
      clusterSecretStoreConfiguration:
        enabled: true
        clusterSecretStoreList:
          - name: vault-secrets
            source:
              provider: vault
              server: "https://vault.example.com:8200"
              path: kv
              version: v2
              auth:
                type: kubernetes
                mountPath: "kubernetes"
                role: "eso-role"
                serviceAccountRef:
                  name: "external-secrets"
                  namespace: "external-secrets"
```

## Fetching Secrets with ExternalSecret

Once the ClusterSecretStore is configured, create ExternalSecret resources to fetch data from Vault. The `name` field must match the ClusterSecretStore name defined above.

### Using individual keys (`data`)

```yaml
addons:
  externalSecrets:
    enabled: true
    values:
      externalSecretsConfiguration:
        enabled: true
        secretList:
          - name: vault-secrets
            namespace: external-secrets
            secrets:
              targetName: my-app-secret
              targetPolicy: "Owner"
              data:
                - secretKey: username
                  remoteRef:
                    key: my-app/config
                    property: username
                - secretKey: password
                  remoteRef:
                    key: my-app/config
                    property: password
```

### Using all keys from a path (`dataFrom`)

```yaml
addons:
  externalSecrets:
    enabled: true
    values:
      externalSecretsConfiguration:
        enabled: true
        secretList:
          - name: vault-secrets
            namespace: external-secrets
            secrets:
              targetName: my-app-secret
              targetPolicy: "Owner"
              dataFrom:
                - extract:
                    key: my-app/config
```

## Troubleshooting

### ClusterSecretStore shows `InvalidProviderConfig` with 503

**Symptom**: `upstream connect error or disconnect/reset before headers. retried and the latest reset reason: remote connection failure, transport failure reason: delayed connect error: Connection refused`

**Causes and fixes:**

1. **Missing Istio AuthorizationPolicy on Vault**: The Vault namespace has a deny-all AuthorizationPolicy. Add the `customAuthorizationPolicies` shown in the [Prerequisites](#network-and-istio-requirements) section to your Vault override values.

2. **Missing vault-ingress pod label**: Verify ESO pods have the `vault-ingress: "true"` label. This is defaulted by the chart but can be overridden:
   ```bash
   kubectl get pods -n external-secrets -l app.kubernetes.io/name=external-secrets -o jsonpath='{.items[0].metadata.labels.vault-ingress}'
   ```
   If missing, ensure your values include:
   ```yaml
   upstream:
     podLabels:
       vault-ingress: "true"
   ```

3. **NetworkPolicies not enabled**: Ensure `networkPolicies.enabled: true` is set in your ESO values so the egress policy to Vault is created.

### Invalid vault credentials with non-printable characters

If you encounter `invalid vault credentials: configured Vault token contains non-printable characters and cannot be used`, trim the token before creating the secret:

```bash
TOKEN_CLEAN="$(tr -d '\r\n' < /path/to/token)"
kubectl create secret generic vault-token -n external-secrets --from-literal=token="$TOKEN_CLEAN"
```
