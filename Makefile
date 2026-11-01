K8S_VERSION ?= 1.31.0
CRD_SCHEMAS := https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/{{.Group}}/{{.ResourceKind}}_{{.ResourceAPIVersion}}.json
DIRS := cluster workloads config storage networking rbac snippets

.PHONY: validate kubeconform lint
validate: lint kubeconform

kubeconform:
	kubeconform -strict -summary -kubernetes-version $(K8S_VERSION) \
		-schema-location default \
		-schema-location '$(CRD_SCHEMAS)' $(DIRS)

lint:
	yamllint -c .yamllint.yml $(DIRS)
