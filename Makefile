ENV_KUBE_NAMESPACE ?= consumer-load-testing

up:
	kubectl create configmap locust-configmap --from-file=locust-tasks/ -n ${ENV_KUBE_NAMESPACE}
	kubectl apply -f k8s/configmap.yaml -n ${ENV_KUBE_NAMESPACE}
	kubectl apply -f k8s/locust-master.yaml -n ${ENV_KUBE_NAMESPACE}
	kubectl apply -f k8s/locust-slave.yaml -n ${ENV_KUBE_NAMESPACE}
	kubectl create deployment locust-exporter --image=hprateek43/locust-exporter@sha256:fbecfd05c75e310eb630165308a6e85eb5370cb741a5a1b8cd991b299f0d9b53 -n ${ENV_KUBE_NAMESPACE}
	kubectl apply -f k8s/service.yaml -n ${ENV_KUBE_NAMESPACE}
	kubectl apply -f k8s/service-monitor.yaml -n ${ENV_KUBE_NAMESPACE}

down:
    kubectl delete deployment locust-exporter -n ${ENV_KUBE_NAMESPACE}
    kubectl delete svc locust-exporter-service -n ${ENV_KUBE_NAMESPACE}
    kubectl delete servicemonitor locust-exporter-service-monitor -n ${ENV_KUBE_NAMESPACE}
	kubectl delete deployment locust-master -n ${ENV_KUBE_NAMESPACE}
	kubectl delete deployment locust-slave -n ${ENV_KUBE_NAMESPACE}
	kubectl delete configmap locust-configmap -n ${ENV_KUBE_NAMESPACE}
	kubectl delete configmap env-config -n ${ENV_KUBE_NAMESPACE}
