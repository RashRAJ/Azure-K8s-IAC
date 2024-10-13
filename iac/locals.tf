locals {
  argocd_resources_labels = {
    "app.kubernetes.io/instance"  = "argocd"
    "argocd.argoproj.io/instance" = "argocd"
  }

  argocd_resources_annotations = {
    "argocd.argoproj.io/compare-options" = "IgnoreExtraneous"
    "argocd.argoproj.io/sync-options"    = "Prune=false,Delete=false"
  }
}