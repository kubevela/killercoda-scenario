## Use VelaD to setup KubeVela

All you need is run `velad install`, that will help you do things below:

1. start a cluster which needed by KubeVela
2. install KubeVela in cluster
3. install vela CLI on the machine
4. place VelaUX(a web panel addon)resources

```shell
velad install
```{{exec}}

> Note: later we'll use gateway trait. Remember we can use 127.0.0.1:8080 to access application with gateway trait.
Now you have KubeVela available in this computer. To verify install result, check if tools and resources ready,
run `velad status`

RUN 
```
velad status
```{{exec}}

You could use vela CLI now. try check all available component types. Later we'll use `webservice` type component when deploying first app

### Verify Installation

```
export KUBECONFIG=$(velad kubeconfig --host)
vela comp
```{{exec}}
