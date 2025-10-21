<!-- Warning: Do not manually edit this file. See notes on gluon + helm-docs at the end of this file for more information. -->
# external-secrets

![Version: 0.20.3-bb.0](https://img.shields.io/badge/Version-0.20.3--bb.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.20.3](https://img.shields.io/badge/AppVersion-v0.20.3-informational?style=flat-square) ![Maintenance Track: bb_integrated](https://img.shields.io/badge/Maintenance_Track-bb_integrated-green?style=flat-square)

External secrets management for Kubernetes

## Upstream References

- <https://github.com/external-secrets/external-secrets>

## Upstream Release Notes

This package has no upstream release note links on file. Please add some to [chart/Chart.yaml](chart/Chart.yaml) under `annotations.bigbang.dev/upstreamReleaseNotesMarkdown`.
Example:
```yaml
annotations:
  bigbang.dev/upstreamReleaseNotesMarkdown: |
    - [Find our upstream chart's CHANGELOG here](https://link-goes-here/CHANGELOG.md)
    - [and our upstream application release notes here](https://another-link-here/RELEASE_NOTES.md)
```

## Learn More

- [Application Overview](docs/overview.md)
- [Other Documentation](docs/)

## Pre-Requisites

- Kubernetes Cluster deployed
- Kubernetes config installed in `~/.kube/config`
- Helm installed

Kubernetes: `>= 1.19.0-0`

Install Helm

https://helm.sh/docs/intro/install/

## Deployment

- Clone down the repository
- cd into directory

```bash
helm install external-secrets chart/
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| domain | string | `"bigbang.dev"` |  |
| rbac.create | bool | `true` |  |
| rbac.servicebindings.create | bool | `true` |  |
| rbac.aggregateToView | bool | `true` |  |
| rbac.aggregateToEdit | bool | `true` |  |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created. |
| serviceAccount.automount | bool | `true` | Automounts the service account token in all containers of the pod |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account. |
| serviceAccount.extraLabels | object | `{}` | Extra Labels to add to the service account. |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template. |
| scopedNamespace | string | `""` |  |
| scopedRBAC | bool | `false` |  |
| istio.enabled | bool | `false` |  |
| istio.hardened.enabled | bool | `false` |  |
| istio.hardened.outboundTrafficPolicyMode | string | `"REGISTRY_ONLY"` |  |
| istio.hardened.customServiceEntries | list | `[]` |  |
| istio.hardened.customAuthorizationPolicies | list | `[]` |  |
| istio.mtls.mode | string | `"STRICT"` | STRICT = Allow only mutual TLS traffic, PERMISSIVE = Allow both plain text and mutual TLS traffic |
| istio.injection | string | `"disabled"` |  |
| networkPolicies.enabled | bool | `false` |  |
| networkPolicies.ingressLabels.app | string | `"istio-ingressgateway"` |  |
| networkPolicies.ingressLabels.istio | string | `"ingressgateway"` |  |
| networkPolicies.additionalPolicies | list | `[]` |  |
| bbtests.enabled | bool | `false` |  |
| bbtests.namespace | string | `"external-secrets"` |  |
| bbtests.scripts.image | string | `"registry1.dso.mil/ironbank/big-bang/base:2.1.0"` |  |
| bbtests.secretstore.name | string | `"external-secrets-test-store"` |  |
| bbtests.serviceaccount.name | string | `"external-secrets-external-secrets-script-sa"` |  |
| bbtests.secrets.testsecret.value | string | `"this is a magic value"` |  |
| waitJob.enabled | bool | `true` |  |
| waitJob.scripts.image | string | `"registry1.dso.mil/ironbank/opensource/kubernetes/kubectl:v1.33.5"` |  |
| waitJob.permissions.apiGroups[0] | string | `"external-secrets.io"` |  |
| waitJob.permissions.apiGroups[1] | string | `"generators.external-secrets.io"` |  |
| waitJob.permissions.apiGroups[2] | string | `""` |  |
| waitJob.permissions.resources[0] | string | `"acraccesstokens"` |  |
| waitJob.permissions.resources[1] | string | `"clusterexternalsecrets"` |  |
| waitJob.permissions.resources[2] | string | `"clustersecretstores"` |  |
| waitJob.permissions.resources[3] | string | `"ecrauthorizationtokens"` |  |
| waitJob.permissions.resources[4] | string | `"externalsecrets"` |  |
| waitJob.permissions.resources[5] | string | `"fakes"` |  |
| waitJob.permissions.resources[6] | string | `"gcraccesstokens"` |  |
| waitJob.permissions.resources[7] | string | `"githubaccesstokens"` |  |
| waitJob.permissions.resources[8] | string | `"passwords"` |  |
| waitJob.permissions.resources[9] | string | `"pushsecrets"` |  |
| waitJob.permissions.resources[10] | string | `"secretstores"` |  |
| waitJob.permissions.resources[11] | string | `"vaultdynamicsecrets"` |  |
| waitJob.permissions.resources[12] | string | `"webhooks"` |  |
| waitJob.permissions.resources[13] | string | `"secrets"` |  |
| waitJob.permissions.verbs[0] | string | `"create"` |  |
| waitJob.permissions.verbs[1] | string | `"delete"` |  |
| waitJob.permissions.verbs[2] | string | `"get"` |  |
| waitJob.permissions.verbs[3] | string | `"list"` |  |
| waitJob.permissions.verbs[4] | string | `"watch"` |  |
| env.EXTERNAL_SECRETS_NAMESPACE | string | `"external-secrets"` |  |
| clusterSecretStoreConfiguration.enabled | bool | `false` |  |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].name | string | `""` |  |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].namespace | string | `""` |  |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].labels | string | `""` |  |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].annotations | string | `""` |  |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].source | object | `{"auth":{"accessKeyID":"","accessKeyName":"","authType":"","secretAccessKey":""},"provider":"aws","region":"us-gov-west-1","service":"SecretsManager"}` | define types of authentication: ## |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].source.provider | string | `"aws"` | AWS secrets manager only - other services can be added later ## |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].source.service | string | `"SecretsManager"` | Specify type of service, i.e., SecretsManager (default) ## |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].source.region | string | `"us-gov-west-1"` | Specify AWS region, i.e. us-gov-west-1 (default) ## |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].source.auth.authType | string | `""` | Specify authType is required: identity, accesskey or serviceaccount ## |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].source.auth.accessKeyName | string | `""` | Name of the accessKeyID and secretAccessKey pair ## |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].source.auth.accessKeyID | string | `""` | Specify AWS Access Key ID file ## |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].source.auth.secretAccessKey | string | `""` | Specify AWS Secret Access Key file ## |
| externalSecretsConfiguration.enabled | bool | `false` |  |
| externalSecretsConfiguration.secretList[0].name | string | `""` |  |
| externalSecretsConfiguration.secretList[0].namespace | string | `""` |  |
| externalSecretsConfiguration.secretList[0].refreshInterval | string | `"1m"` |  |
| externalSecretsConfiguration.secretList[0].secrets.targetName | string | `""` |  |
| externalSecretsConfiguration.secretList[0].secrets.targetPolicy | string | `"Owner"` | target.creationPolicy default is Owner |
| externalSecretsConfiguration.secretList[0].secrets.secretKeyName | object | `{"key":"","metadataPolicy":"","property":"","version":""}` | This name allows reference by other objects. |
| externalSecretsConfiguration.secretList[0].secrets.secretKeyName.key | string | `""` | Specify key here |
| externalSecretsConfiguration.secretList[0].secrets.secretKeyName.version | string | `""` | Key version |
| externalSecretsConfiguration.secretList[0].secrets.secretKeyName.property | string | `""` | Specify the property of the secret, i.e. username, password |
| externalSecretsConfiguration.secretList[0].secrets.secretKeyName.metadataPolicy | string | `""` | Optional" metadataPolicy for ExternalSecret, i.e. Fetch |
| upstream | object | Upstream chart values           | Values to pass to [the upstream external-secrets chart](https://github.com/external-secrets/external-secrets/blob/main/deploy/charts/external-secrets/values.yaml) |
| upstream.image.tag | string | `"v0.20.3"` | The image tag to use. The default is the chart appVersion. |

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.

---

_This file is programatically generated using `helm-docs` and some BigBang-specific templates. The `gluon` repository has [instructions for regenerating package READMEs](https://repo1.dso.mil/big-bang/product/packages/gluon/-/blob/master/docs/bb-package-readme.md)._

