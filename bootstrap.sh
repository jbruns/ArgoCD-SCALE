#!/bin/bash
adminpassword=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;)

# install ArgoCD
helm dependency update argocd
helm upgrade --install argocd argocd -n argocd --create-namespace --wait --timeout 120s --values globalValues.yaml
kubectl patch secret -n argocd argocd-secret -p '{"stringData": { "admin.password": "'$(htpasswd -bnBC 10 "" ${adminpassword} | tr -d ':\n')'"}}'

echo "ArgoCD admin password has been set to: ${adminpassword}"

# kubectl port-forward -n argocd svc/argocd-server 8080:80
# apply secrets: kubeseal --controller-name sealed-secrets --controller-namespace argo-common -o yaml < infile > outfile