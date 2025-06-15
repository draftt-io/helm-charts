# Draftt Helm Charts

Draftt Helm charts repository.

## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

    helm repo add draftt-io https://draftt-io.github.io/helm-charts

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages. You can then run `helm search repo
draftt-io` to see the charts.

## draftt-explorer

To install the draftt-explorer chart:

    helm install draftt-explorer draftt-io/draftt-explorer

To uninstall the chart:

    helm delete draftt-explorer

Read more about the draftt-explorer chart [here](charts/draftt-explorer/README.md).