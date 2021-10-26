#!/bin/bash
adminpassword=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;)

helm dependency update argocd
helm dependency update argocd-applicationset
helm upgrade --install argocd argocd -n argocd --create-namespace --wait --timeout 120s --values globalValues.yaml
helm upgrade --install argocd-applicationset argocd-applicationset -n argocd --wait --timeout 120s
kubectl patch secret -n argocd argocd-secret -p '{"stringData": { "admin.password": "'$(htpasswd -bnBC 10 "" ${adminpassword} | tr -d ':\n')'"}}'

echo "ArgoCD admin password has been set to: ${adminpassword}"

# iptables -D INPUT -p tcp -m tcp --dport 6443 -m comment --comment "iX Custom Rule to drop connection requests to k8s cluster from external sources" -j DROP
# kubectl port-forward -n argocd svc/argocd-server 8080:80
# apply secrets: kubeseal --controller-name sealed-secrets --controller-namespace argo-common -o yaml < infile > outfile