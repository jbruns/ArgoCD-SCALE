#!/bin/bash
adminpassword=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;)

# check if helm is installed
if ! command -v helm &> /dev/null; then
  # install helm
  curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
fi

# check if argocd exists
if ! helm ls -q --namespace argocd | grep -q '^argocd$'; then
  # add argocd repo
  helm repo add argo https://argoproj.github.io/argo-helm || true # Add the ArgoCD chart repository
  helm repo update # Update the repositories

  # install argocd
  helm dependency update argocd # Update the dependencies
  helm upgrade --install argocd argo/argocd -n argocd --create-namespace --wait --timeout 120s --values globalValues.yaml # Install or upgrade the ArgoCD release
fi

# update argocd password
kubectl patch secret -n argocd argocd-secret -p '{"stringData": { "admin.password": "'$(htpasswd -bnBC 10 "" ${adminpassword} | tr -d ':\n')'"}}' # Patch the admin password of the ArgoCD secret in the argocd namespace
echo "ArgoCD admin password has been set to: ${adminpassword}"

# kubectl port-forward -n argocd svc/argocd-server 8080:80
# apply secrets: kubeseal --controller-name sealed-secrets --controller-namespace argo-common -o yaml < infile > outfile
