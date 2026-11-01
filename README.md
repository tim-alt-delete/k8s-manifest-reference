# Kubernetes manifest reference

A browsable reference of Kubernetes manifests. Each file is a valid manifest with a comment on
(nearly) every field, so you can look up a kind and copy what you need.
All files are validated against the Kubernetes 1.31 schema.

Files refer to each other with consistent names in namespace `example` (e.g. `app-config`,
`db-credentials`, `data-pvc`, `app-sa`), so they work together as one sample app.
Secret values are fake placeholders.

## Index

| Category | Kind | File |
|---|---|---|
| cluster | Namespace | [cluster/namespace.yaml](cluster/namespace.yaml) |
| cluster | ResourceQuota | [cluster/resourcequota.yaml](cluster/resourcequota.yaml) |
| cluster | LimitRange | [cluster/limitrange.yaml](cluster/limitrange.yaml) |
| cluster | PriorityClass | [cluster/priorityclass.yaml](cluster/priorityclass.yaml) |
| workloads | Pod (minimal + full spec reference) | [workloads/pod.yaml](workloads/pod.yaml) |
| workloads | Deployment | [workloads/deployment.yaml](workloads/deployment.yaml) |
| workloads | ReplicaSet | [workloads/replicaset.yaml](workloads/replicaset.yaml) |
| workloads | StatefulSet | [workloads/statefulset.yaml](workloads/statefulset.yaml) |
| workloads | DaemonSet | [workloads/daemonset.yaml](workloads/daemonset.yaml) |
| workloads | Job | [workloads/job.yaml](workloads/job.yaml) |
| workloads | CronJob | [workloads/cronjob.yaml](workloads/cronjob.yaml) |
| workloads | HorizontalPodAutoscaler | [workloads/horizontalpodautoscaler.yaml](workloads/horizontalpodautoscaler.yaml) |
| workloads | PodDisruptionBudget | [workloads/poddisruptionbudget.yaml](workloads/poddisruptionbudget.yaml) |
| config | ConfigMap | [config/configmap.yaml](config/configmap.yaml) |
| config | Secret (Opaque, tls, dockerconfigjson, basic-auth, ssh-auth, SA token) | [config/secret.yaml](config/secret.yaml) |
| storage | StorageClass | [storage/storageclass.yaml](storage/storageclass.yaml) |
| storage | PersistentVolume | [storage/persistentvolume.yaml](storage/persistentvolume.yaml) |
| storage | PersistentVolumeClaim | [storage/persistentvolumeclaim.yaml](storage/persistentvolumeclaim.yaml) |
| networking | Service (ClusterIP, NodePort, LoadBalancer, headless, ExternalName) | [networking/service.yaml](networking/service.yaml) |
| networking | EndpointSlice | [networking/endpointslice.yaml](networking/endpointslice.yaml) |
| networking | Ingress, IngressClass | [networking/ingress.yaml](networking/ingress.yaml) |
| networking | NetworkPolicy | [networking/networkpolicy.yaml](networking/networkpolicy.yaml) |
| rbac | ServiceAccount | [rbac/serviceaccount.yaml](rbac/serviceaccount.yaml) |
| rbac | Role | [rbac/role.yaml](rbac/role.yaml) |
| rbac | ClusterRole | [rbac/clusterrole.yaml](rbac/clusterrole.yaml) |
| rbac | RoleBinding | [rbac/rolebinding.yaml](rbac/rolebinding.yaml) |
| rbac | ClusterRoleBinding | [rbac/clusterrolebinding.yaml](rbac/clusterrolebinding.yaml) |

### Snippets (pod-spec deep dives)

Complete Pods focused on one topic, so they validate on their own.

| Topic | File |
|---|---|
| Every volume type | [snippets/volumes.yaml](snippets/volumes.yaml) |
| Probe types and lifecycle hooks | [snippets/probes-and-lifecycle.yaml](snippets/probes-and-lifecycle.yaml) |
| Affinity, tolerations, topology spread | [snippets/scheduling.yaml](snippets/scheduling.yaml) |
| Requests/limits and QoS classes | [snippets/resources-and-qos.yaml](snippets/resources-and-qos.yaml) |

## Conventions

- `---` separates multiple variants in one file; each is introduced by a comment.
- Workload controllers embed a Pod spec at `spec.template.spec`; see `workloads/pod.yaml`.
- Not included: CRD-based kinds (Gateway API, VolumeSnapshot, cert-manager, ...).

## Validation

```sh
make validate      # yamllint + kubeconform
make kubeconform   # schema check only
make K8S_VERSION=1.30.0 kubeconform
```

Requires [kubeconform](https://github.com/yannh/kubeconform) and `yamllint`. CI runs the same.
