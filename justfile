_default:
    just -l

update:
    for chart in k8s/*; do helm dependency update $chart; done

kustomize:
    kubectl kustomize --enable-helm k8s/system

deploy:
    kubectx blahaj

    helm upgrade -n phoenix k8s k8s/main
    helm upgrade -n system-metrics system-metrics k8s/system-metrics
