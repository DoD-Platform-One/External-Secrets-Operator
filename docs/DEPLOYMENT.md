# Deploying External Secrets Operator

The External Secrets Operator may be deployed like any other bigbang package. Use this YAML as an example:

```
addons:
  externalSecrets:
    enabled: true
    git:
      repo: https://repo1.dso.mil/big-bang/product/packages/external-secrets.git
      path: chart
    values:
      bbtests:
        enabled: true
```

... and you can deploy it normally, as part of the bigbang umbrella chart:

```
bbctl deploy bigbang -- -f externalsecrets.yaml
```

... or manually with helm (assuming an appropriately configured environment with a namespace, registry secrets, etc):

```
helm upgrade -i --wait external-secrets chart/ -n external-secrets
```

# Helm tests

If you want to run helm tests against your deployment, you will need to deploy with bbtests enabled:

```
addons:
  externalSecrets:
    values:
      bbtests:
        enabled: true
```

This will create a skeleton secret store that is sufficient to prove that ESO is working. Then you can execute the helm tests:

```
$ helm test external-secrets -n external-secrets
```

# Deploy Standardized ESO ClusterSecretStore for AWS Secret Manager 

The complete data model/schema is located in the ESO package values.yaml under [clusterSecretStoreConfiguration](https://repo1.dso.mil/big-bang/product/packages/external-secrets/-/blob/main/chart/values.yaml?ref_type=heads#L121) section.

This section is to demonstrate what is needed for deployment.  User can evaluate the requirements and adjust in their own environment accordingly.

### Create a secret containing your AWS credentials

This is needed for the accesskey example below.  
```
echo -n 'KEYID' > ./access-key
echo -n 'SECRETKEY' > ./secret-access-key
kubectl create secret generic awssm-secret --from-file=./access-key --from-file=./secret-access-key [-n namespace]
```

### Examples of the override file - required to provide AWS information 

There are three types of authentication methods: accesskey, serveraccount or identity.  One method of authentication is required and examples are provided below.

##### Authentication method: accesskey example

Note: When using the accesskey method for authentication, the kubernetes secret that stores the access key pair (as create in the section Create a secret containing your AWS credentials) need to be present in the same name space as the target or the namespace specified in the externalSecretsConfiguration.

```
addons:
  externalSecrets:
    enabled: true
    git:
      repo: https://repo1.dso.mil/big-bang/apps/sandbox/external-secrets.git
      tag: 0.12.1-bb.1
    values:
      bbtests:
        enabled: true
      clusterSecretStoreConfiguration:
        enabled: true
        clusterSecretStoreList:
          - name: "team-a-store"
            namespace: default
            labels: ""
            annotations: ""
            # define types of authentication: ##
            source: 
              # AWS secrets manager only - other services can be added later ##
              provider: aws 
              # Specify type of service, i.e., SecretsManager (default) ##
              service: SecretsManager 
              # Specify AWS region, i.e. us-gov-west-1 (default) ##
              region: "us-gov-west-1"
              auth:
                # Specify authType is required: identity, accesskey or serviceaccount ##
                authType: "accesskey"  
                # Name of the accessKeyID and secretAccessKey pair ##
                accessKeyName: "awssm-secret" 
                # Specify AWS Access Key ID file ##
                accessKeyID: "access-key"
                # Specify AWS Secret Access Key file ##
                secretAccessKey: "secret-access-key"                
```

##### Authentication method: serviceaccount example

Note: Be sure to provide namespace where the service account resides.

```
addons:
  externalSecrets:
    enabled: true
    git:
      repo: https://repo1.dso.mil/big-bang/apps/sandbox/external-secrets.git
      tag: 0.12.1-bb.1
    values:
      bbtests:
        enabled: true
      clusterSecretStoreConfiguration:
        enabled: true
        clusterSecretStoreList:
          - name: "team-b-store"
            namespace: "default"
            labels: ""
            annotations: ""
            source:
              # AWS secrets manager only - request for other services can be added later
              provider: aws
              # Specify type of service, i.e., SecretsManager (default)
              service: "SecretsManager"
              # Specify the name of the service, secretStoreRef.name
              serviceName: ""
              # Specify AWS region, i.e. us-gov-west-1, default is us-gov-west-1
              region: us-gov-west-1
              auth:
                # Specify which authentication to use: identity, accesskey, serviceaccount
                authType: "serviceaccount"
                # Name of a service account
                serviceAccount: "my-serviceaccount"                
```

##### Authentication method: identity example

```
addons:
  externalSecrets:
    enabled: true
    git:
      repo: https://repo1.dso.mil/big-bang/apps/sandbox/external-secrets.git
      tag: 0.12.1-bb.1 
    values:
      bbtests:
        enabled: true
      clusterSecretStoreConfiguration:
        enabled: true
        clusterSecretStoreList:
          - name: "team-c-store"
            namespace: "default"
            labels: ""
            annotations: ""
            source:
              # AWS secrets manager only - request for other services can be added later
              provider: aws
              # Specify type of service, i.e., SecretsManager (default)
              service: "SecretsManager"
              # Specify the name of the service, secretStoreRef.name
              serviceName: ""
              # Specify AWS region, i.e. us-gov-west-1, default is us-gov-west-1
              region: us-gov-west-1
              auth:
                # Specify which authentication to use: identity, accesskey, serviceaccount
                authType: "identity"
                # Optional: Name of role that defines fine-grained access
                role: ""
```

For the identity example, please also see [AWS_INTEGRATION.md](https://repo1.dso.mil/big-bang/product/packages/external-secrets/-/blob/main/docs/AWS_INTEGRATION.md?ref_type=heads) and follow the steps in the Identity Authentication Method section to setup the IAM roles and trust relationships.

After authentication method is determined, one needs to decide what data to fetch.  Secrets section, as shown below, can specify the name of the secret in the AWS Secret Manager, name you want to assign in the k8s secret, version (assigned by aws) and property (how to slice the secret data).

The following examples can be appended after one of the authentication snippets above.

There are two methods for data fetching.  One is to get everything and another is get a slice it.

##### Example below uses this secret as an example.  This is store in AWS Secrets Manager > Secrets > engineerlist:

The name of this Secrets is engineerlist.
```
{
  "name": {"first": "Tom", "last": "Anderson"},
  "friends": [
    {"first": "Dale", "last": "Murphy"},
    {"first": "Roger", "last": "Craig"},
    {"first": "Jane", "last": "Murphy"}
  ]
}
```

##### To fetch all data in Secrets engineerlist. 

If neither .Values.externalSecretsConfiguration.secretList.secrets.secretKeyName.property nor .Values.externalSecretsConfiguration.secretList.secrets.secretKeyName.version is specified, all data in the Secrets engineerlist will be fetched.

```
              secrets:
                targetName: "k8s-secret"
                targetPolicy: "Owner"
                targetSecretKey:
                secretKeyName:
                  key: engineerlist 
```

##### To fetch sliced data in Secret engineerlist:

Use .Values.externalSecretsConfiguration.secretList.secrets.secretKeyName.property to slice part of Secrets.
For example, to fetch "Roger" in engineerlist above, one can specify 'property: friends.1.first'.  If the list "friends" is needed, use 'property: friends'.  

Use .Values.externalSecretsConfiguration.secretList.secrets.secretKeyName.version to specify the VersionId (uuid) or VersionStage assigned by AWS.  
VersionStage can take either AWSCURRENT or AWSPREVIOUS.

```
              secrets:
                targetName: "minio-secret"
                targetPolicy: "Owner"
                secretKeyName:
                  key: "engineerlist"
                  version: "AWSCURRENT"
                  property: friends.1.first
```

Note: if neither property nor version is specified, it will default to the above example that will fetch all data in the Secrets engineerlist.