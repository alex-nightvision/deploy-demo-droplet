# deploy-demo-droplet

The `./run.sh` should handle all software installation, env var checks, file checks and running the playbook

# Apps supported:

- https://github.com/vulnerable-apps/vuln_django_play
- https://github.com/vulnerable-apps/javaspringvulny
- https://github.com/OWASP/railsgoat
- https://github.com/alex-nightvision/owasp-webgoat-dot-net-docker
- https://github.com/alex-nightvision/xss-fastapi

# kube setup

[Install agent notes](https://docs.datadoghq.com/containers/kubernetes/installation/?tab=operator)
```
# only need to do this once
helm repo add datadog https://helm.datadoghq.com
helm install my-datadog-operator datadog/datadog-operator

# for every new node we want to add in run the following
cluster_name="public-firing-range"
DD_API_KEY="$YOUR_DD_API_KEY"

helm install datadog -n datadog \
    --set datadog.clusterName="$cluster_name" \
    --set datadog.site='us5.datadoghq.com' \
    --set datadog.clusterAgent.replicas='2' \
    --set datadog.clusterAgent.createPodDisruptionBudget='true' \
    --set datadog.logs.enabled=true \
    --set datadog.logs.containerCollectAll=true \
    --set datadog.apiKey="$DD_API_KEY" \
    --set datadog.processAgent.enabled=true \
    datadog/datadog --create-namespace
```

# Droplet is max on CPU utilization

This happens sometimes just refresh all the apps with the script `refresh-apps.sh`