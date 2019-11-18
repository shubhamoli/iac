#!/bin/sh

helm install stable/nginx-ingress --set service.type=LoadBalancer --namespace ingress-nginx
helm install stable/prometheus --namespace monitoring-prod --generate-name
helm install stable/grafana -f monitoring/values.yml --namespace monitoring-prod --generate-name


# Grafana username: admin
# get grafan pass using
echo " To get Grafana Password \n\n run: kubectl get secret --namespace monitoring-prod grafana -o jsonpath=\"{.data.admin-password}\" | base64 --decode ; echo" 