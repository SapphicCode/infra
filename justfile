_default:
    just -l

update:
    helm dependency update k8s

deploy:
    kubectx blahaj
    kubens phoenix
    helm upgrade k8s k8s
