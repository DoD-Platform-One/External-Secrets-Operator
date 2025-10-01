# Upgrading this Package

The below details the steps required to update to a new version of the External Secrets package.

1. Review the [upstream release notes](https://github.com/external-secrets/external-secrets/releases) for the update you are going to, as well as any versions skipped over between the last BB release and this one. Note any breaking changes and new features.

2. Use `kpt` to pull the upstream chart via the latest tag that corresponds to the application version. From the root of the repo run `kpt pkg update chart@helm-chart-0.9.18 --strategy alpha-git-patch` replacing `helm-chart-0.9.18` with the version tag you got in step 1. Also update the custom resource definitions using the same chart version `kpt pkg update chart/crds@helm-chart-0.9.18 --strategy alpha-git-patch`.

3. Based on the upstream changelog review from earlier, make any changes required to resolve breaking changes and reconcile the Big Bang modifications.

4. Modify the `version` in `Chart.yaml`. Also modify the `appVersion` and the `bigbang.dev/applicationVersions` to the new upstream version of External Secrets. 

5. Update helm dependencies to latest library versions.
    ```
    helm dependency update ./chart
    ```

6. Update `CHANGELOG.md` adding an entry for the new version and noting all changes (at minimum should include `Updated External Secrets Operator to x.x.x`).

7. Generate the `README.md` updates by following the [guide in gluon](https://repo1.dso.mil/platform-one/big-bang/apps/library-charts/gluon/-/blob/master/docs/bb-package-readme.md).

8. Open an MR in "Draft" status and validate that CI passes. This will perform a number of smoke tests against the package, but it is good to manually deploy to test some things that CI doesn't. Follow the steps below for manual testing.

9. Once all manual testing is complete take your MR out of "Draft" status and add the review label.

# How to test the upgrade

## Cluster setup

Always make sure your local bigbang repo is current before deploying.

1. Export your Ironbank/Harbor credentials (this can be done in your ~/.bashrc or ~/.zshrc file if desired). These specific variables are expected by the k3d-dev.sh script when deploying metallb, and are referenced in other commands for consistency:

```
export REGISTRY_USERNAME='<your_username>'
export REGISTRY_PASSWORD='<your_password>'
```
2. Export the path to your local bigbang repo (without a trailing /):
Note that wrapping your file path in quotes when exporting will break expansion of ~.
```
export BIGBANG_REPO_DIR=<absolute_path_to_local_bigbang_repo>
```
e.g.
```
export BIGBANG_REPO_DIR=~/repos/bigbang
```
3. Run the k3d_dev.sh script to deploy a dev cluster (-a flag required if deploying a local Keycloak):
```
"${BIGBANG_REPO_DIR}/docs/assets/scripts/developer/k3d-dev.sh"
```
4. Export your kubeconfig:
```
export KUBECONFIG=~/.kube/<your_kubeconfig_file>
```
e.g.
```
export KUBECONFIG=~/.kube/Sam.Sarnowski-dev-config
```
5. Deploy flux to your cluster:
```
"${BIGBANG_REPO_DIR}/scripts/install_flux.sh -u ${REGISTRY_USERNAME} -p ${REGISTRY_PASSWORD}"
```
## Deploy Bigbang External-secrets
```
helm upgrade -i bigbang ${BIGBANG_REPO_DIR}/chart/ -n bigbang --create-namespace \
--set registryCredentials.username=${REGISTRY_USERNAME} --set registryCredentials.password=${REGISTRY_PASSWORD} \
-f https://repo1.dso.mil/big-bang/bigbang/-/raw/master/tests/test-values.yaml \
-f https://repo1.dso.mil/big-bang/bigbang/-/raw/master/chart/ingress-certs.yaml \
-f docs/dev-overrides/minimal.yaml \
-f docs/dev-overrides/external-secrets-testing.yaml
```

## Big Bang Integration Testing

As part of your MR that modifies bigbang packages, you should modify the bigbang [bigbang/tests/test-values.yaml](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/tests/test-values.yaml?ref_type=heads) against your branch for the CI/CD MR testing by enabling your packages.

To do this, at a minimum, you will need to follow the instructions at [bigbang/docs/developer/test-package-against-bb.md](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/docs/developer/test-package-against-bb.md?ref_type=heads) with changes for externalSecrets enabled (the below is a reference, actual changes could be more depending on what changes where made to externalSecrets in the pakcage MR).

# Testing for updates

NOTE: For these testing steps it is good to do them on both a clean install and an upgrade. For clean install, point external-secrets to your branch. For an upgrade do an install with external-secrets pointing to the latest tag, then perform a helm upgrade with external-secrets pointing to your branch.

To install External Secrets Operator as a community package in a Big Bang Kubernetes Cluster, see the [deployment documentation](DEPLOYMENT.md) and follow the instructions there. 

Testing Steps:
- Ensure all resources have reconciled and are healthy
- Run the helm tests and ensure they pass

When in doubt with any testing or upgrade steps ask one of the CODEOWNERS for assistance.

# Big Bang Chart Additions

This chart has no Big Bang specific additions at this time.

# Files that need integration testing

If you modify any of these things, you should perform an integration test with your branch against the rest of bigbang. Some of these files have automatic tests already defined, but those automatic tests may not model corner cases found in full integration scenarios.

* `./chart/crds/`
* `./chart/templates/bigbang/*`
* `./chart/templates/rbac.yaml`
* `./chart/templates/webhook*`
* `./chart/values.yaml` if it involves any of:
  * monitoring changes
  * network policy changes
  * kyverno policy changes
  * istio hardening rule changes
  * service definition changes
  * TLS settings

Follow [the standard process](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/docs/developer/test-package-against-bb.md?ref_type=heads) for performing an integration test against bigbang.