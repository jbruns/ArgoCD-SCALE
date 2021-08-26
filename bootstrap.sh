#!/bin/bash
adminpassword=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;)

helm dependency update argocd
helm dependency update argocd-applicationset
helm upgrade --install argo-cd argocd -n argocd --create-namespace --wait --timeout 120s
helm upgrade --install argocd-applicationset argocd-applicationset -n argocd --wait --timeout 120s
kubectl patch secret -n argocd argocd-secret -p '{"stringData": { "admin.password": "'$(htpasswd -bnBC 10 "" ${adminpassword} | tr -d ':\n')'"}}'

echo "ArgoCD admin password has been set to: ${adminpassword}"
