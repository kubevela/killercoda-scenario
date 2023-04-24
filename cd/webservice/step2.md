You also can deploy the application via CLI.

> You can find the deployment files in `/tmp/webservice-app.yaml`.

RUN `vela up -f /tmp/webservice-app.yaml`{{exec}}

> The application created by CLI will be synced to UI automatically.

Next, check the deployment status of the application through `vela status webservice-app`{{exec}}

```
About:

  Name:      	test-app
  Namespace: 	default
  Created at:	2022-04-21 12:03:42 +0800 CST
  Status:    	running

...snip...

Services:

  - Name: frontend
    Cluster: local  Namespace: default
    Type: webservice
    Healthy Ready:1/1
    Traits:
      ✅ scaler
```

Depending on how you install KubeVela, you can choose the way to access the [endpoint]({{TRAFFIC_HOST1_8080}}).

```shell
vela port-forward webservice-app -n default 8080:8080
```{{exec}}

This command will open a browser automatically. Or you could access the endpoint by [URL]({{TRAFFIC_HOST1_8080}}) in your browser.

Now, you have finished learning the basic delivery for container images. Then, you could:

* Refer to [webservice details](https://kubevela.io/docs/end-user/components/references#webservice) to know usage of full fields.
* Refer to [trait reference](https://kubevela.io/docs/end-user/traits/references) to know which traits can be used for webservice.
* Refer to [multi-cluster delivery](https://kubevela.io/docs/case-studies/multi-cluster) to know how to deploy container image into hybrid environment and multi-clusters.
