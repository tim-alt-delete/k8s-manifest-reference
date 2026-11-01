K8S_VERSION ?= 1.31.0
DIRS := cluster workloads config storage networking rbac snippets

.PHONY: validate kubeconform lint
validate: lint kubeconform

kubeconform:
	kubeconform -strict -summary -kubernetes-version $(K8S_VERSION) \
		-schema-location default $(DIRS)

lint:
	yamllint -c .yamllint.yml $(DIRS)
