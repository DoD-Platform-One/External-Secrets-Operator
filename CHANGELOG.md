# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [unreleased]

### Changed

- updated charts/templates/bigbang/external-secrets.yaml to allow multiple secrets to be built into one kubernetes secret object

## [0.16.2-bb.1] - 2025-05-20

### Changed

- Updated CRDs to match upstream 0.16.2

## [0.16.2-bb.0] - 2025-05-06

### Changed

- Updated helm-chart to 0.16.2
- Updated gluon 0.5.15 -> 0.5.17
- Updated registry1.dso.mil/ironbank/opensource/kubernetes/kubectl (source) v1.32.3 -> v1.32.4

## [0.16.1-bb.1] - 2025-05-06

### Changed

- Removed unneeded files for bbtests scripts

## [0.16.1-bb.0] - 2025-04-28
### Changed

- Updated registry1.dso.mil/ironbank/opensource/external-secrets/external-secrets v0.15.1 -> v0.16.1
- Updated registry1.dso.mil/ironbank/opensource/kubernetes/kubectl v1.31.7 -> v1.32.3

## [0.15.1-bb.1] - 2025-04-21

### Added

- Added ESO gluon test scripts in chart/templates/tests/test-script.yaml
- Added a ESO server test bash script in chart/tests/script/

## [0.15.1-bb.0] - 2025-04-15

### Changed

- gluon 0.5.14 -> 0.5.15
- registry1.dso.mil/ironbank/opensource/external-secrets/external-secrets v0.15.0 -> v0.15.1
- registry1.dso.mil/ironbank/opensource/kubernetes/kubectl v1.30.11 -> v1.31.7

## [0.15.0-bb.1] - 2025-04-09

### Changed

- Updated deployment documentation to reflect changes
- Split clusterSecretStore and secrets creation in the values file
- Updated waitJob to mount configmap as environment
- Removed hardcoded clustersecretstore suffix

## [0.15.0-bb.0] - 2025-03-21

### Changed

- registry1.dso.mil/ironbank/opensource/external-secrets/external-secrets v0.14.4 -> v0.15.0
- registry1.dso.mil/ironbank/opensource/kubernetes/kubectl v1.30.10 -> v1.30.11

## [0.14.4-bb.0] - 2025-03-12

### Changed

- registry1.dso.mil/ironbank/opensource/external-secrets/external-secrets v0.14.3 -> v0.14.4

## [0.14.3-bb.1] - 2025-03-11

### Changed

- Resolve errors from enabling drift detection for ESO

## [0.14.3-bb.0] - 2025-02-28

### Changed

- Updated registry1.dso.mil/ironbank/opensource/external-secrets/external-secrets (source) v0.14.2 -> v0.14.3

## [0.14.2-bb.0] - 2025-02-19

### Changed

- Updated registry1.dso.mil/ironbank/opensource/external-secrets/external-secrets (source) v0.14.1 -> v0.14.2
- Updated registry1.dso.mil/ironbank/opensource/kubernetes/kubectl (source) v1.30.9 -> v1.30.10

## [0.14.1-bb.0] - 2025-02-13

### Changed

- Updated registry1.dso.mil/ironbank/opensource/external-secrets/external-secrets (source) v0.14.0 -> v0.14.1

## [0.14.0-bb.0] - 2025-02-10

### Changed

- Updated registry1.dso.mil/ironbank/opensource/external-secrets/external-secrets (source) v0.13.0 -> v0.14.0

## [0.13.0-bb.2] - 2025-02-05

### Changed

- Removed hardcoded matchLabels

## [0.13.0-bb.1] - 2025-02-03

### Changed

- Updated kpt file to reflect new update to v0.13.0

## [0.13.0-bb.0] - 2025-01-29

### Changed

- Updated registry1.dso.mil/ironbank/opensource/external-secrets/external-secrets v0.12.1 -> v0.13.0
- Updated registry1.dso.mil/ironbank/opensource/kubernetes/kubectl -> v1.30.8 -> v1.30.9

## [0.12.1-bb.2] - 2024-01-16

### Added

- Updated gluon 0.5.12 -> 0.5.14

## [0.12.1-bb.1] - 2024-01-09

### Added

- Added data fetch logic

## [0.12.1-bb.0] - 2025-01-07

### Changed

- Updated chart to v0.12.1

## [0.11.0-bb.3] - 2024-12-17

### Changed

- Removed hardcoded namespace

## [0.11.0-bb.2] - 2024-12-12

### Changed

- Updated kubectl v1.30.7 -> v1.30.8

## [0.11.0-bb-1] - 2024-12-11

### Changed

- Added data block in ES for secret versioning

## [0.11.0-bb.0] - 2024-12-4

### Changed

- Updated chart to v0.11.0
- Updated gluon to 0.5.12
- Updated kubectl to v1.30.7

## [0.10.4-bb.1] - 2024-11-14

### Changed

- Removed namespace in the secret-store.yaml template
- Added ExternalSecret template using secretConfiguration

## [0.10.4-bb.0] - 2024-11-12

### Added

- Updated chart to v0.10.4
- Updated to gluon 0.5.4
- Added the maintenance track annotation and badge

## [0.10.2-bb.5] - 2024-10-31

### Added

- Added a gluon wait script to wait until the validating webhook is functional before completing the helm release
- Updated the gluon dependency to v0.5.10

## [0.10.2-bb.3] - 2024-10-23

### Changed

- Fix resource ordering to correct a hidden test failure that was giving false confidence

## [0.10.2-bb.2] - 2024-10-17

### Added

- Create secret store based off of provided user values

## [0.10.2-bb.1] - 2024-10-02

### Added

- Added network policy allow-sidecar-scraping

## [0.10.2-bb.0] - 2024-08-30

### Changed

- Updated ESO to v0.10.2
- Updated to gluon 0.5.3

## [0.9.20-bb.3] - 2024-08-19

### Changed

- Added label for webhook

## [0.9.20-bb.2] - 2024-08-01

### Changed

- Updated to gluon 0.5.2

## [0.9.20-bb.1] - 2024-07-26

### Changed

- Updated to gluon 0.5.1

## [0.9.20-bb.0] - 2024-07-17

### Changed

- Updated ESO to v0.9.20
- Updated to gluon 0.5.0

## [0.9.18-bb.8] - 2024-07-12

### Changed

- Added integration testing instructions for External Secrets Operator

## [0.9.18-bb.7] - 2024-07-03

### Changed

- Fixed kyverno polciy issues with external-secrets-test-secret-mount

## [0.9.18-bb.6] - 2024-07-03

### Changed

- Fixed kyvero policy issue setting runAsGroup: 1000

## [0.9.18-bb.5] - 2024-06-13

### Changed

- Added istio authorization policies

## [0.9.18-bb.4] - 2024-06-10

### Added

- Added istio PeerAuthorization policies

## [0.9.18-bb.3] - 2024-06-05

### Changed

- Corrected an issue in the deployment documentation

## [0.9.18-bb.2] - 2024-06-02

### Added

- Added helm test to validate that the external secrets operator is functional

## [0.9.18-bb.1] - 2024-05-28

### Added

- Add Resource values for every pod to set Guaranteed QoS

## [0.9.18-bb.0] - 2024-05-15

### Changed

- update "custom_resources" <https://github.com/external-secrets/external-secrets> from "v0.9.15" (57521cd87ead96f0b1f550bc04f2edcb45b56071) to "helm-chart-0.9.18" (b8f27d6b0a35ff0b6b8a1772799364e271bcd294)
- update "external-secrets" <https://github.com/external-secrets/external-secrets> from "v0.9.15" (3d96be0d53817cde9e1c431b4b51550614e064df) to "helm-chart-0.9.18" (b8f27d6b0a35ff0b6b8a1772799364e271bcd294)
- Updated to gluon 0.4.10

## [0.9.16-bb.0] - 2024-05-22

### Added

- Updated chart to v0.9.16
- Added network policies

## [0.9.15-bb.3] - 2024-05-15

### Added

- Added renovate configuration to external-secrets opensource app

## [0.9.15-bb.2] - 2024-05-11

### Added

- KPT pull for upstream custom resource definitions bundle
- kustomizations to deploy custom resources before the helm release

## [0.9.15-bb.1] - 2024-05-03

### Added

- Generate README.md

## [0.9.15-bb.0] - 2024-04-30

### Initial

- Pull latest chart with kpt
