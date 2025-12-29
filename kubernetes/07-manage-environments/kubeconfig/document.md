# Kubeconfig

specifying the kubeconfig file 

```bash

kubectl get nodes --kubeconfig k8s-homologacao.yaml

kubectl get nodes --kubeconfig k8s-production.yaml


```

## View kubeconfig content

```bash

# to view the kubeconfig content
kubectl config view --flatten

# mertge
KUBECONFIG=~/aula/k8s-production-kubeconfig.yaml kubectl config view --flatte > merged-confing.yaml

```


checking the option

```bash

kubectl config

# output
Modify kubeconfig files using subcommands like "kubectl config set
current-context my-context".

 The loading order follows these rules:

  1.  If the --kubeconfig flag is set, then only that file is loaded. The flag
may only be set once and no merging takes place.
  2.  If $KUBECONFIG environment variable is set, then it is used as a list of
paths (normal path delimiting rules for your system). These paths are merged.
When a value is modified, it is modified in the file that defines the stanza.
When a value is created, it is created in the first file that exists. If no
files in the chain exist, then it creates the last file in the list.
  3.  Otherwise, ${HOME}/.kube\config is used and no merging takes place.

Available Commands:
  current-context   Display the current-context
  delete-cluster    Delete the specified cluster from the kubeconfig
  delete-context    Delete the specified context from the kubeconfig
  delete-user       Delete the specified user from the kubeconfig
  get-clusters      Display clusters defined in the kubeconfig
  get-contexts      Describe one or many contexts
  get-users         Display users defined in the kubeconfig
  rename-context    Rename a context from the kubeconfig file
  set               Set an individual value in a kubeconfig file
  set-cluster       Set a cluster entry in kubeconfig
  set-context       Set a context entry in kubeconfig
  set-credentials   Set a user entry in kubeconfig
  unset             Unset an individual value in a kubeconfig file
  use-context       Set the current-context in a kubeconfig file
  view              Display merged kubeconfig settings or a specified kubeconfig
file

Usage:
  kubectl config SUBCOMMAND [options]

Use "kubectl config <command> --help" for more information about a given
command.
Use "kubectl options" for a list of global command-line options (applies to all
commands).



kubectl config  get-clusters

# output

NAME
k3d-mycluster
do-nyc3-aula-02

# getting the context
kubectl config  get-contexts
CURRENT   NAME              CLUSTER           AUTHINFO                NAMESPACE
          do-nyc3-aula-02   do-nyc3-aula-02   do-nyc3-aula-02-admin
*         k3d-mycluster     k3d-mycluster     admin@k3d-mycluster

# setting the context
kubectl config use-context do-nyc3-aula-02

```

## Setting a default  namespace

```bash

kubectl config set-context --current --namespace=app-abc

```

## Tools to help you

[kubectx](https://kubectx.dev/)

### Context

```bash

#get a list of contexts
kubectx

# set a  in the context
kubectx [context name]

kubectx do-nyc3-aula-02

# go back to the previous context
kubectx -

```




### Namespace

```bash

#get a list of namespace
kubens

# set a  in the context
kubens [namespace name]

kubens kube-system

# go back to the previous context
kubens -

```