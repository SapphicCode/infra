_default:
    just -l

update:
    for chart in k8s/*; do helm dependency update $chart; done

kustomize:
    kubectl kustomize --enable-helm k8s/system

kubectx:
    kubectx blahaj

# deploying nginx takes forever, that's why it's separate
deploy-nginx: kubectx
    helm upgrade --install --create-namespace -n system-nginx system-nginx k8s/system-nginx

deploy: kubectx
    kubectl get namespace/system-nginx || just deploy-nginx
    helm upgrade --install --create-namespace -n phoenix k8s k8s/main
    helm upgrade --install --create-namespace -n system-metrics system-metrics k8s/system-metrics
