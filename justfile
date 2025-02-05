_default:
    just -l

update:
    for chart in k8s/*; do helm dependency update $chart; done

kustomize:
    kubectl kustomize --enable-helm k8s/system

deploy:
    kubectx blahaj
    kubens phoenix

    helm upgrade k8s k8s/main

    kubectl kustomize --enable-helm k8s/system | kubectl apply -f -
