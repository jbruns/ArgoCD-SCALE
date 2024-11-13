# Archived
All good things must come to an end, I suppose. 

iXsystems [shifted gears](https://forums.truenas.com/t/the-future-of-electric-eel-and-apps/5409) from including k3s in TrueNAS SCALE, to just making it a Docker[-compose] host. I think that's likely for the better, and while it was an amazing opportunity to learn more about Kubernetes and GitOps principles, the resulting level of complication is a *little* extreme when you consider a single-node, at-home use case. That point aside - I was quite pleased with acheiving wife (and kids!) approved Kubernetes back in 2021, running all the way to when I finally took the upgrade to `SCALE-current` in Nov 2024.

Before accepting the move to Docker Compose, I did make an attempt to largely move this repository over to [Talos Linux](https://github.com/jbruns/ArgoCD-Talos). But, again, the cons in overhead and extra steps just didn't make a lot of sense in my environment.

If any of this repo's content is helpful to you, great! If you are looking for ready-made Helm charts to run on top of Talos or your Kubernetes distribution of choice, see [TrueCharts](https://truecharts.org). Otherwise, the common chart and container images I reference below are a great start to your journey.

<br>

<img src="https://raw.githubusercontent.com/jbruns/ArgoCD-SCALE/main/logo.png" align="left" width="144px" height="144px"/>

# "HomeProd" - GitOps on Kubernetes
_Maximum availability, minimum hassle. Managed by ArgoCD, maintained by Renovate._
<br>
<br>
## :book:&nbsp; Overview
Kubernetes? At Home?
<br>
While I wouldn't fault you for saying that this is an awfully complicated way to run services at home, it allows for an incredibly straightforward pattern of being able to do anything from tinkering/developing on Kubernetes, all the way to running stuff that we depend on to store and preserve our family's photos. Therefore I like to think of it as _Just Enough Kubernetes_ - Production-worthy for our purposes, but not so out there that I'm constantly fighting with it.
<br>
<br>
What you see here, then, is the authoritative source for my cluster's configuration: 

- [ArgoCD](https://argoproj.github.io/cd/) keeps watch over this Git repository, and makes changes accordingly to the cluster based on commits. 
- Bitnami [sealed-secrets](https://github.com/bitnami-labs/sealed-secrets) is what's used to encrypt secrets in a way that allows them to be kept in a public repo.

Currently I only have a single node, which is running [TrueNAS SCALE](https://www.truenas.com). k3s comes as part of the distribution, so it takes very little effort to fully integrate GitOps principles into it.

## :robot:&nbsp; Automation

* [Renovate](https://github.com/renovatebot/renovate) keeps workloads up-to-date by scanning the repo and opening pull requests when it detects a new container image update or a new helm chart

## :handshake:&nbsp; Community

Thanks to all the people who donate their time to the [Home Operations](https://discord.com/invite/home-operations/) community.
This repo would not exist if it wasn't for the excellent people there sharing what they know.

I'd like to especially call out these community projects, which I rely on heavily:

* [Common Library Chart](https://bjw-s.github.io/helm-charts/docs/common-library/)
* [Container Images](https://github.com/onedr0p?tab=packages&repo_name=containers)

_How do I get started with my own Kubernetes @ Home project?_ It all starts with this [template.](https://github.com/onedr0p/cluster-template)