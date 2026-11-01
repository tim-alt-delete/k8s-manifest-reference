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
| networking | GatewayClass (Gateway API) | [networking/gatewayclass.yaml](networking/gatewayclass.yaml) |
| networking | Gateway (HTTP, HTTPS, TLS passthrough listeners) | [networking/gateway.yaml](networking/gateway.yaml) |
| networking | HTTPRoute (HTTP-to-HTTPS redirect, matches, filters, canary, timeouts) | [networking/httproute.yaml](networking/httproute.yaml) |
| networking | GRPCRoute | [networking/grpcroute.yaml](networking/grpcroute.yaml) |
| networking | TLSRoute | [networking/tlsroute.yaml](networking/tlsroute.yaml) |
| networking | BackendTLSPolicy | [networking/backendtlspolicy.yaml](networking/backendtlspolicy.yaml) |
| networking | ReferenceGrant | [networking/referencegrant.yaml](networking/referencegrant.yaml) |
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
- Gateway API (standard channel, v1.7) is included; experimental kinds, VolumeSnapshot and
  cert-manager are not.

## Gateway API notes

Gateway API is the successor to Ingress. It is a set of CRDs plus a controller you install
yourself; the manifests are controller-neutral, with Envoy Gateway used for examples.

- Install the CRDs: `kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.7.0/standard-install.yaml`
- Platform team owns GatewayClass and Gateway (namespace `infra`); app teams own routes in their
  namespace. Cross-namespace references need a ReferenceGrant.
- Fields that only work with a specific controller are marked `CONTROLLER-SPECIFIC`
  (`controllerName`, `parametersRef`, cloud LB annotations).
- Extended features (e.g. RequestMirror) and some timeouts/retry options vary by controller.
  Check `status.conditions` (Accepted, Programmed) on the Gateway and routes.
- Policies such as rate limiting, auth and WAF are controller-specific CRDs, not covered here.
- CRD schemas for validation come from the
  [datreeio CRDs-catalog](https://github.com/datreeio/CRDs-catalog).

## Validation

```sh
make validate      # yamllint + kubeconform
make kubeconform   # schema check only
make K8S_VERSION=1.30.0 kubeconform
```

Requires [kubeconform](https://github.com/yannh/kubeconform) and `yamllint`. CI runs the same.
