resource "kubernetes_namespace" "argocd" {
  depends_on = [data.azurerm_kubernetes_cluster.default]

  metadata {
    name = "argocd"
  }
}

resource "kubernetes_secret" "argocd_repo_credentials" {
  depends_on = [kubernetes_namespace.argocd]

  metadata {
    name      = "argocd-repo-credentials"
    namespace = "argocd"
    labels = merge(local.argocd_resources_labels, {
      "argocd.argoproj.io/secret-type" = "repo-creds"
    })
    annotations = local.argocd_resources_annotations
  }
  type = "Opaque"
  data = {
    url           = "git@github.com:RashRAJ/Azure-K8s-IAC.git"
    sshPrivateKey = file("~/.ssh/id_rsa")
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "6.0.5"
  skip_crds  = true
  depends_on = [
    kubernetes_secret.argocd_repo_credentials,
  ]
  values = [
    file("argocd-values/argocd-values.yaml"),
  ]
}

resource "kubectl_manifest" "argocd_bootstrap" {
  depends_on = [helm_release.argocd]

  yaml_body = yamlencode({
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"

    metadata = {
      name      = "argocd-aks" #changes this to apps
      namespace = "argocd"
    }

    spec = {
      project= "default"
      destination = {
        namespace = "argocd"
        name      = "in-cluster"
      }
      source = {
        repoURL = "git@github.com:RashRAJ/Azure-K8s-IAC/" #add path and taget revision
        helm = {
          values = yamlencode({
            network = {
              public = {
                # domain = "aks-poc.ORG.com"
                ipName = data.azurerm_public_ip.public_lb.name
                ip     = data.azurerm_public_ip.public_lb.ip_address
              }
            }
          })
        }
      }
    }
  })

}
