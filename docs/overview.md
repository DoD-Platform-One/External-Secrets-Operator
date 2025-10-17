# External Secrets Operator

## Overview

External Secrets Operator is a Kubernetes controller that syncs secrets from external providers (AWS Secrets Manager, Azure Key Vault, HashiCorp Vault, GCP Secret Manager, etc...) into native Secret objects in your cluster. It does this via CRDs.

Please review the BigBang [Architecture Document](https://repo1.dso.mil/big-bang/bigbang/-/tree/master) for more information about its role within BigBang.

## Dependencies

This chart depends on the [External Secrets Operator](https://repo1.dso.mil/big-bang/bigbang/-/tree/master) Big Bang package.

## How it works

This chart works by deploying an instance of External Secrets Operator using the External Secrets Operator Instance CRD which is created by the External Secrets Operator. To deploy External Secrets Operator, `External Secrets OperatorOperator` and `External Secrets Operator` must both be enabled through the addons functionality in the Big Bang [values.yaml](https://repo1.dso.mil/platform-one/big-bang/bigbang/-/blob/master/chart/values.yaml). This will create the External Secrets Operator in the `External Secrets Operator` namespace and an instance of External Secrets Operator in the `External Secrets Operator` namespace.

1. You install ESO via Helm.

2. You define a store (how to auth to the provider).

3. You define an ExternalSecret (what keys to pull, any templating, refresh policy).

4. ESO reconciles: reads from the provider, creates/updates a Kubernetes Secret, and keeps it fresh when the source changes.

## External Resources

If you'd like to learn more about the External Secrets Operator application and its features, see their [official documentation](https://charts.external-secrets.io).


## Granting Egress to Blocked Services

When Istio hardening is enabled through the settings `istio.enabled` and `istio.enabled.hardened`, a sidecar is injected into the External Secrets Operator namespace. This sidecar limits network traffic to 'REGISTRY_ONLY', effectively blocking access to external services.

> **Note:** Access to external services will be blocked.


### Discovering Blocked Hosts

To find out which hosts are being blocked, inspect the `istio-proxy` logs from the 'External Secrets Operator' pod using the following commands:

```bash
export SOURCE_POD=$(kubectl -n ESO get pod -l name=ESO -o jsonpath={.items..metadata.name})
kubectl -n ESO logs "$SOURCE_POD" -c istio-proxy | grep -i "BlackHoleCluster"
```

Here is an example of a `customServiceEntry` that can be added to your Big Bang `values.yaml`
```yaml
istioGateway:
  enabled: true
  hardened:
    enabled: true
    customServiceEntries:
     - name: "allow-amazonaws"
       enabled: true
       spec:
         hosts:
           - "<bucket-name>.s3.us-gov-west-1.amazonaws.com"
         location: MESH_EXTERNAL
         exportTo:
         - "."
         ports:
         - name: https
           number: 443
           protocol: TLS
         resolution: DNS
```

