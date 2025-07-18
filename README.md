<!-- Warning: Do not manually edit this file. See notes on gluon + helm-docs at the end of this file for more information. -->
# external-secrets

![Version: 0.18.2-bb.0](https://img.shields.io/badge/Version-0.18.2--bb.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.18.2](https://img.shields.io/badge/AppVersion-v0.18.2-informational?style=flat-square) ![Maintenance Track: bb_integrated](https://img.shields.io/badge/Maintenance_Track-bb_integrated-green?style=flat-square)

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
| openshift | bool | `false` |  |
| global.nodeSelector | object | `{}` |  |
| global.tolerations | list | `[]` |  |
| global.topologySpreadConstraints | list | `[]` |  |
| global.affinity | object | `{}` |  |
| global.compatibility.openshift.adaptSecurityContext | string | `"auto"` | Manages the securityContext properties to make them compatible with OpenShift. Possible values: auto - Apply configurations if it is detected that OpenShift is the target platform. force - Always apply configurations. disabled - No modification applied. |
| replicaCount | int | `1` |  |
| bitwarden-sdk-server.enabled | bool | `false` |  |
| revisionHistoryLimit | int | `10` | Specifies the amount of historic ReplicaSets k8s should keep (see https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#clean-up-policy) |
| image.repository | string | `"registry1.dso.mil/ironbank/opensource/external-secrets/external-secrets"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.tag | string | `"v0.18.2"` | The image tag to use. The default is the chart appVersion. |
| image.flavour | string | `""` | The flavour of tag you want to use There are different image flavours available, like distroless and ubi. Please see GitHub release notes for image tags for these flavors. By default, the distroless image is used. |
| installCRDs | bool | `false` | If set, install and upgrade CRDs through helm chart. |
| crds.createClusterExternalSecret | bool | `true` | If true, create CRDs for Cluster External Secret. |
| crds.createClusterSecretStore | bool | `true` | If true, create CRDs for Cluster Secret Store. |
| crds.createClusterGenerator | bool | `true` | If true, create CRDs for Cluster Generator. |
| crds.createPushSecret | bool | `true` | If true, create CRDs for Push Secret. |
| crds.annotations | object | `{}` |  |
| crds.conversion.enabled | bool | `false` | Conversion is disabled by default as we stopped supporting v1alpha1. |
| imagePullSecrets[0].name | string | `"private-registry"` |  |
| nameOverride | string | `""` |  |
| fullnameOverride | string | `""` |  |
| namespaceOverride | string | `""` |  |
| commonLabels | object | `{}` | Additional labels added to all helm chart resources. |
| leaderElect | bool | `false` | If true, external-secrets will perform leader election between instances to ensure no more than one instance of external-secrets operates at a time. |
| controllerClass | string | `""` | If set external secrets will filter matching Secret Stores with the appropriate controller values. |
| extendedMetricLabels | bool | `false` | If true external secrets will use recommended kubernetes annotations as prometheus metric labels. |
| scopedNamespace | string | `""` | If set external secrets are only reconciled in the provided namespace |
| scopedRBAC | bool | `false` | Must be used with scopedNamespace. If true, create scoped RBAC roles under the scoped namespace and implicitly disable cluster stores and cluster external secrets |
| processClusterExternalSecret | bool | `true` | if true, the operator will process cluster external secret. Else, it will ignore them. |
| processClusterStore | bool | `true` | if true, the operator will process cluster store. Else, it will ignore them. |
| processPushSecret | bool | `true` | if true, the operator will process push secret. Else, it will ignore them. |
| createOperator | bool | `true` | Specifies whether an external secret operator deployment be created. |
| concurrent | int | `1` | Specifies the number of concurrent ExternalSecret Reconciles external-secret executes at a time. |
| log | object | `{"level":"info","timeEncoding":"epoch"}` | Specifices Log Params to the External Secrets Operator |
| service.ipFamilyPolicy | string | `""` | Set the ip family policy to configure dual-stack see [Configure dual-stack](https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services) |
| service.ipFamilies | list | `[]` | Sets the families that should be supported and the order in which they should be applied to ClusterIP as well. Can be IPv4 and/or IPv6. |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created. |
| serviceAccount.automount | bool | `true` | Automounts the service account token in all containers of the pod |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account. |
| serviceAccount.extraLabels | object | `{}` | Extra Labels to add to the service account. |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template. |
| clusterSecretStoreConfiguration.enabled | bool | `false` |  |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].name | string | `""` |  |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].namespace | string | `""` |  |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].labels | string | `""` |  |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].annotations | string | `""` |  |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].source | object | `{"auth":{"accessKeyID":"","accessKeyName":"","authType":"","secretAccessKey":""},"provider":"aws","refreshInterval":"1m","region":"us-gov-west-1","service":"SecretsManager"}` | define types of authentication: ## |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].source.provider | string | `"aws"` | AWS secrets manager only - other services can be added later ## |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].source.service | string | `"SecretsManager"` | Specify type of service, i.e., SecretsManager (default) ## |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].source.region | string | `"us-gov-west-1"` | Specify AWS region, i.e. us-gov-west-1 (default) ## |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].source.refreshInterval | string | `"1m"` | Secret pull refresh interval.  Default is 1m. |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].source.auth | object | `{"accessKeyID":"","accessKeyName":"","authType":"","secretAccessKey":""}` | Frequency to check for updates ## |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].source.auth.authType | string | `""` | Specify authType is required: identity, accesskey or serviceaccount ## |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].source.auth.accessKeyName | string | `""` | Name of the accessKeyID and secretAccessKey pair ## |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].source.auth.accessKeyID | string | `""` | Specify AWS Access Key ID file ## |
| clusterSecretStoreConfiguration.clusterSecretStoreList[0].source.auth.secretAccessKey | string | `""` | Specify AWS Secret Access Key file ## |
| externalSecretsConfiguration.enabled | bool | `false` |  |
| externalSecretsConfiguration.secretList[0].name | string | `"secret-1"` |  |
| externalSecretsConfiguration.secretList[0].namespace | string | `""` |  |
| externalSecretsConfiguration.secretList[0].secrets.targetName | string | `""` |  |
| externalSecretsConfiguration.secretList[0].secrets.targetPolicy | string | `""` | target.creationPolicy default is Owner |
| externalSecretsConfiguration.secretList[0].secrets.secretKeyName | object | `{"key":"","metadataPolicy":"","property":"","version":""}` | This name allows reference by other objects. |
| externalSecretsConfiguration.secretList[0].secrets.secretKeyName.key | string | `""` | Specify key here |
| externalSecretsConfiguration.secretList[0].secrets.secretKeyName.version | string | `""` | Key version |
| externalSecretsConfiguration.secretList[0].secrets.secretKeyName.property | string | `""` | Specify the property of the secret, i.e. username, password |
| externalSecretsConfiguration.secretList[0].secrets.secretKeyName.metadataPolicy | string | `""` | Optional" metadataPolicy for ExternalSecret, i.e. Fetch |
| rbac.create | bool | `true` | Specifies whether role and rolebinding resources should be created. |
| rbac.servicebindings.create | bool | `true` | Specifies whether a clusterrole to give servicebindings read access should be created. |
| rbac.aggregateToView | bool | `true` | Specifies whether permissions are aggregated to the view ClusterRole |
| rbac.aggregateToEdit | bool | `true` | Specifies whether permissions are aggregated to the edit ClusterRole |
| extraEnv | list | `[]` |  |
| extraArgs | object | `{}` |  |
| extraVolumes | list | `[]` |  |
| extraObjects | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraContainers | list | `[]` |  |
| deploymentAnnotations | object | `{}` | Annotations to add to Deployment |
| podAnnotations | object | `{}` | Annotations to add to Pod |
| podLabels | object | `{}` |  |
| podSecurityContext.enabled | bool | `true` |  |
| securityContext.allowPrivilegeEscalation | bool | `false` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.enabled | bool | `true` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `1000` |  |
| securityContext.runAsGroup | int | `1000` |  |
| securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| resources.requests.memory | string | `"256Mi"` |  |
| resources.requests.cpu | string | `"100m"` |  |
| resources.limits.cpu | string | `"100m"` |  |
| resources.limits.memory | string | `"256Mi"` |  |
| serviceMonitor.enabled | bool | `false` | Specifies whether to create a ServiceMonitor resource for collecting Prometheus metrics |
| serviceMonitor.namespace | string | `""` | namespace where you want to install ServiceMonitors |
| serviceMonitor.additionalLabels | object | `{}` | Additional labels |
| serviceMonitor.interval | string | `"30s"` | Interval to scrape metrics |
| serviceMonitor.scrapeTimeout | string | `"25s"` | Timeout if metrics can't be retrieved in given time interval |
| serviceMonitor.honorLabels | bool | `false` | Let prometheus add an exported_ prefix to conflicting labels |
| serviceMonitor.metricRelabelings | list | `[]` | Metric relabel configs to apply to samples before ingestion. [Metric Relabeling](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs) |
| serviceMonitor.relabelings | list | `[]` | Relabel configs to apply to samples before ingestion. [Relabeling](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config) |
| metrics.listen.port | int | `8080` |  |
| metrics.service.enabled | bool | `false` | Enable if you use another monitoring tool than Prometheus to scrape the metrics |
| metrics.service.port | int | `8080` | Metrics service port to scrape |
| metrics.service.annotations | object | `{}` | Additional service annotations |
| grafanaDashboard.enabled | bool | `false` | If true creates a Grafana dashboard. |
| grafanaDashboard.sidecarLabel | string | `"grafana_dashboard"` | Label that ConfigMaps should have to be loaded as dashboards. |
| grafanaDashboard.sidecarLabelValue | string | `"1"` | Label value that ConfigMaps should have to be loaded as dashboards. |
| grafanaDashboard.annotations | object | `{}` | Annotations that ConfigMaps can have to get configured in Grafana, See: sidecar.dashboards.folderAnnotation for specifying the dashboard folder. https://github.com/grafana/helm-charts/tree/main/charts/grafana |
| nodeSelector | object | `{}` |  |
| tolerations | list | `[]` |  |
| topologySpreadConstraints | list | `[]` |  |
| affinity | object | `{}` |  |
| priorityClassName | string | `""` | Pod priority class name. |
| podDisruptionBudget | object | `{"enabled":false,"minAvailable":1}` | Pod disruption budget - for more details see https://kubernetes.io/docs/concepts/workloads/pods/disruptions/ |
| hostNetwork | bool | `false` | Run the controller on the host network |
| webhook.create | bool | `false` | Specifies whether a webhook deployment be created. The default behavior of ESO in bigbang at this time is to NOT deploy the validating webhook. There is a bug that is still unresolved which causes the cert-controller and validating webhook to come up unhealthy more often than not. Beware that enabling these options may result in an unhealthy deployment. |
| webhook.certCheckInterval | string | `"5m"` | Specifices the time to check if the cert is valid |
| webhook.lookaheadInterval | string | `""` | Specifices the lookaheadInterval for certificate validity |
| webhook.replicaCount | int | `1` |  |
| webhook.log | object | `{"level":"info","timeEncoding":"epoch"}` | Specifices Log Params to the Webhook |
| webhook.revisionHistoryLimit | int | `10` | Specifies the amount of historic ReplicaSets k8s should keep (see https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#clean-up-policy) |
| webhook.certDir | string | `"/tmp/certs"` |  |
| webhook.failurePolicy | string | `"Fail"` | Specifies whether validating webhooks should be created with failurePolicy: Fail or Ignore |
| webhook.hostNetwork | bool | `false` | Specifies if webhook pod should use hostNetwork or not. |
| webhook.image.repository | string | `"registry1.dso.mil/ironbank/opensource/external-secrets/external-secrets"` |  |
| webhook.image.pullPolicy | string | `"IfNotPresent"` |  |
| webhook.image.tag | string | `"v0.18.2"` | The image tag to use. The default is the chart appVersion. |
| webhook.image.flavour | string | `""` | The flavour of tag you want to use |
| webhook.imagePullSecrets[0].name | string | `"private-registry"` |  |
| webhook.nameOverride | string | `""` |  |
| webhook.fullnameOverride | string | `""` |  |
| webhook.port | int | `10250` | The port the webhook will listen to |
| webhook.rbac.create | bool | `true` | Specifies whether role and rolebinding resources should be created. |
| webhook.serviceAccount.create | bool | `true` | Specifies whether a service account should be created. |
| webhook.serviceAccount.automount | bool | `true` | Automounts the service account token in all containers of the pod |
| webhook.serviceAccount.annotations | object | `{}` | Annotations to add to the service account. |
| webhook.serviceAccount.extraLabels | object | `{}` | Extra Labels to add to the service account. |
| webhook.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template. |
| webhook.nodeSelector | object | `{}` |  |
| webhook.certManager.enabled | bool | `false` | Enabling cert-manager support will disable the built in secret and switch to using cert-manager (installed separately) to automatically issue and renew the webhook certificate. This chart does not install cert-manager for you, See https://cert-manager.io/docs/ |
| webhook.certManager.addInjectorAnnotations | bool | `true` | Automatically add the cert-manager.io/inject-ca-from annotation to the webhooks and CRDs. As long as you have the cert-manager CA Injector enabled, this will automatically setup your webhook's CA to the one used by cert-manager. See https://cert-manager.io/docs/concepts/ca-injector |
| webhook.certManager.cert.create | bool | `true` | Create a certificate resource within this chart. See https://cert-manager.io/docs/usage/certificate/ |
| webhook.certManager.cert.issuerRef | object | `{"group":"cert-manager.io","kind":"Issuer","name":"my-issuer"}` | For the Certificate created by this chart, setup the issuer. See https://cert-manager.io/docs/reference/api-docs/#cert-manager.io/v1.IssuerSpec |
| webhook.certManager.cert.duration | string | `"8760h"` | Set the requested duration (i.e. lifetime) of the Certificate. See https://cert-manager.io/docs/reference/api-docs/#cert-manager.io/v1.CertificateSpec One year by default. |
| webhook.certManager.cert.renewBefore | string | `""` | How long before the currently issued certificate’s expiry cert-manager should renew the certificate. See https://cert-manager.io/docs/reference/api-docs/#cert-manager.io/v1.CertificateSpec Note that renewBefore should be greater than .webhook.lookaheadInterval since the webhook will check this far in advance that the certificate is valid. |
| webhook.certManager.cert.annotations | object | `{}` | Add extra annotations to the Certificate resource. |
| webhook.tolerations | list | `[]` |  |
| webhook.topologySpreadConstraints | list | `[]` |  |
| webhook.affinity | object | `{}` |  |
| webhook.priorityClassName | string | `""` | Pod priority class name. |
| webhook.podDisruptionBudget | object | `{"enabled":false,"minAvailable":1}` | Pod disruption budget - for more details see https://kubernetes.io/docs/concepts/workloads/pods/disruptions/ |
| webhook.metrics.listen.port | int | `8080` |  |
| webhook.metrics.service.enabled | bool | `false` | Enable if you use another monitoring tool than Prometheus to scrape the metrics |
| webhook.metrics.service.port | int | `8080` | Metrics service port to scrape |
| webhook.metrics.service.annotations | object | `{}` | Additional service annotations |
| webhook.readinessProbe.address | string | `""` | Address for readiness probe |
| webhook.readinessProbe.port | int | `8081` | ReadinessProbe port for kubelet |
| webhook.extraEnv | list | `[]` |  |
| webhook.extraArgs | object | `{}` |  |
| webhook.extraVolumes | list | `[]` |  |
| webhook.extraVolumeMounts | list | `[]` |  |
| webhook.secretAnnotations | object | `{}` | Annotations to add to Secret |
| webhook.deploymentAnnotations | object | `{}` | Annotations to add to Deployment |
| webhook.podAnnotations | object | `{}` | Annotations to add to Pod |
| webhook.podLabels."external-secrets.io/component" | string | `"webhook"` |  |
| webhook.podSecurityContext.enabled | bool | `true` |  |
| webhook.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| webhook.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| webhook.securityContext.enabled | bool | `true` |  |
| webhook.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| webhook.securityContext.runAsNonRoot | bool | `true` |  |
| webhook.securityContext.runAsUser | int | `1000` |  |
| webhook.securityContext.runAsGroup | int | `1000` |  |
| webhook.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| webhook.resources.requests.memory | string | `"256Mi"` |  |
| webhook.resources.requests.cpu | string | `"100m"` |  |
| webhook.resources.limits.cpu | string | `"100m"` |  |
| webhook.resources.limits.memory | string | `"256Mi"` |  |
| certController.create | bool | `false` | Specifies whether a certificate controller deployment be created. The default behavior of ESO in bigbang at this time is to NOT create a cert controller. There is a bug that is still unresolved which causes the cert-controller and validating webhook to come up unhealthy more often than not. Beware that enabling these options may result in an unhealthy deployment. |
| certController.requeueInterval | string | `"5m"` |  |
| certController.replicaCount | int | `1` |  |
| certController.log | object | `{"level":"info","timeEncoding":"epoch"}` | Specifices Log Params to the Certificate Controller |
| certController.revisionHistoryLimit | int | `10` | Specifies the amount of historic ReplicaSets k8s should keep (see https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#clean-up-policy) |
| certController.image.repository | string | `"registry1.dso.mil/ironbank/opensource/external-secrets/external-secrets"` |  |
| certController.image.pullPolicy | string | `"IfNotPresent"` |  |
| certController.image.tag | string | `"v0.18.2"` |  |
| certController.image.flavour | string | `""` |  |
| certController.imagePullSecrets[0].name | string | `"private-registry"` |  |
| certController.nameOverride | string | `""` |  |
| certController.fullnameOverride | string | `""` |  |
| certController.rbac.create | bool | `true` | Specifies whether role and rolebinding resources should be created. |
| certController.serviceAccount.create | bool | `true` | Specifies whether a service account should be created. |
| certController.serviceAccount.automount | bool | `true` | Automounts the service account token in all containers of the pod |
| certController.serviceAccount.annotations | object | `{}` | Annotations to add to the service account. |
| certController.serviceAccount.extraLabels | object | `{}` | Extra Labels to add to the service account. |
| certController.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template. |
| certController.nodeSelector | object | `{}` |  |
| certController.tolerations | list | `[]` |  |
| certController.topologySpreadConstraints | list | `[]` |  |
| certController.affinity | object | `{}` |  |
| certController.hostNetwork | bool | `false` | Run the certController on the host network Upstream bug reports related to the ongoing cert-controller/validating webhook issue indicate that in some EKS and GCP deployments, using `hostNetwork: true` may resolve some issues. |
| certController.priorityClassName | string | `""` | Pod priority class name. |
| certController.podDisruptionBudget | object | `{"enabled":false,"minAvailable":1}` | Pod disruption budget - for more details see https://kubernetes.io/docs/concepts/workloads/pods/disruptions/ |
| certController.metrics.listen.port | int | `8080` |  |
| certController.metrics.service.enabled | bool | `false` | Enable if you use another monitoring tool than Prometheus to scrape the metrics |
| certController.metrics.service.port | int | `8080` | Metrics service port to scrape |
| certController.metrics.service.annotations | object | `{}` | Additional service annotations |
| certController.readinessProbe.address | string | `""` | Address for readiness probe |
| certController.readinessProbe.port | int | `8081` | ReadinessProbe port for kubelet |
| certController.extraEnv | list | `[]` |  |
| certController.extraArgs | object | `{}` |  |
| certController.extraVolumes | list | `[]` |  |
| certController.extraVolumeMounts | list | `[]` |  |
| certController.deploymentAnnotations | object | `{}` | Annotations to add to Deployment |
| certController.podAnnotations | object | `{}` | Annotations to add to Pod |
| certController.podLabels | object | `{}` |  |
| certController.podSecurityContext.enabled | bool | `true` |  |
| certController.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| certController.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| certController.securityContext.enabled | bool | `true` |  |
| certController.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| certController.securityContext.runAsNonRoot | bool | `true` |  |
| certController.securityContext.runAsUser | int | `1000` |  |
| certController.securityContext.runAsGroup | int | `1000` |  |
| certController.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| certController.resources.requests.memory | string | `"256Mi"` |  |
| certController.resources.requests.cpu | string | `"100m"` |  |
| certController.resources.limits.cpu | string | `"100m"` |  |
| certController.resources.limits.memory | string | `"256Mi"` |  |
| dnsPolicy | string | `"ClusterFirst"` | Specifies `dnsPolicy` to deployment |
| dnsConfig | object | `{}` | Specifies `dnsOptions` to deployment |
| podSpecExtra | object | `{}` | Any extra pod spec on the deployment |
| domain | string | `"bigbang.dev"` |  |
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
| bbtests.serviceaccount.name | string | `"external-secrets-script-sa"` |  |
| bbtests.secrets.testsecret.value | string | `"this is a magic value"` |  |
| waitJob.enabled | bool | `true` |  |
| waitJob.scripts.image | string | `"registry1.dso.mil/ironbank/opensource/kubernetes/kubectl:v1.32.6"` |  |
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

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.

---

_This file is programatically generated using `helm-docs` and some BigBang-specific templates. The `gluon` repository has [instructions for regenerating package READMEs](https://repo1.dso.mil/big-bang/product/packages/gluon/-/blob/master/docs/bb-package-readme.md)._

