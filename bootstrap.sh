#!/bin/bash

# Generate a random password for the ArgoCD admin user
adminpassword=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;)

# Check if helm is installed and install if missing
if ! command -v helm &> /dev/null
then
    echo "Helm not found. Installing helm..."
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
fi

# Check if argocd helm repo is added and add if missing
if ! helm repo list | grep argo &> /dev/null
then
    echo "ArgoCD helm repo not found. Adding ArgoCD helm repo..."
    helm repo add argo https://argoproj.github.io/argo-helm
fi

# Install ArgoCD using helm
helm dependency update argocd
helm upgrade --install argocd argocd -n argocd --create-namespace --wait --timeout 120s --values globalValues.yaml

# Set the ArgoCD admin password
kubectl patch secret -n argocd argocd-secret -p '{"stringData": { "admin.password": "'$(htpasswd -bnBC 10 "" ${adminpassword} | tr -d ':\n')'"}}'

# Print the generated password to the console
echo "ArgoCD admin password has been set to: ${adminpassword}"

# Uncomment these lines if you want to port-forward the ArgoCD server to localhost:8080 and/or use kubeseal for secrets management
# kubectl port-forward -n argocd svc/argocd-server 8080:80
# kubeseal --controller-name sealed-secrets --controller-namespace argo-common -o yaml < infile > outfile
