<img src="https://camo.githubusercontent.com/5b298bf6b0596795602bd771c5bddbb963e83e0f/68747470733a2f2f692e696d6775722e636f6d2f7031527a586a512e706e67" align="left" width="144px" height="144px"/>

# "HomeProd" - GitOps on Kubernetes
_ Maximum availability, minimum hassle. Managed by ArgoCD, maintained by Renovate.

## :book:&nbsp; Overview

Kubernetes? At Home?
I'd like to think of this as "Just Enough Kubernetes" to make things as easy as possible, so that I'm not constantly fighting with services at home (but I'm also not trying to run infrastructure that is _so beyond complicated_ that I can't get anything done). What you see here, then, is the authoritative source for my cluster's configuration: [ArgoCD](https://argoproj.github.io/cd/) keeps watch over this Git repository, and makes changes accordingly to the cluster based on commits. Bitnami [sealed-secrets](https://github.com/bitnami-labs/sealed-secrets) is what's used to encrypt secrets in a way that allows them to be kept in a public repo.

Currently I only have a single node, which is running [TrueNAS SCALE](https://www.truenas.com). k3s comes as part of the distribution, so it takes very little effort to fully integrate GitOps principles into it.

## :robot:&nbsp; Automation

* [Renovate](https://github.com/renovatebot/renovate) keeps workloads up-to-date by scanning the repo and opening pull requests when it detects a new container image update or a new helm chart

## :handshake:&nbsp; Community

Thanks to all the people who donate their time to the [k8s@home](https://github.com/k8s-at-home/) community.
This repo would not exist if it wasn't for the shared knowledge.

Do you want to know more? It all starts with this [template](https://github.com/k8s-at-home/template-cluster-k3s/)