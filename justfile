_default:
    just -l

update:
    for chart in k8s/*; do helm dependency update $chart; done

kustomize:
    kubectl kustomize --enable-helm k8s/system

kubectx:
    kubectx blahaj

deploy-ts *ARGS:
    helm repo add tailscale https://pkgs.tailscale.com/helmcharts
    helm upgrade --install --create-namespace -n system-tailscale {{ARGS}} tailscale-operator tailscale/tailscale-operator

deploy: kubectx
    helm upgrade --install --create-namespace -n system-traefik --values k8s/system-traefik.yaml traefik traefik/traefik
    helm upgrade --install --create-namespace -n phoenix k8s k8s/main
    helm upgrade --install --create-namespace -n system-metrics system-metrics k8s/system-metrics

lock:
    helm dependency update k8s/app
