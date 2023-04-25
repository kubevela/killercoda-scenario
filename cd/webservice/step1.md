You can deploy the application via CLI.

> You can find the sample file in `filesystem` -> `webservice-app.yaml` on the IDE Editor.

RUN `vela up -f /webservice-app.yaml`{{exec}}

> The application created by CLI will be synced to UI automatically.

Next, check the deployment status of the application through 

```vela status webservice-app```{{exec}}

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

When the Status changes to `running`, your sample application is deployed, you can view it by:

```
vela port-forward webservice-app -n default 8080:8080 --address='0.0.0.0'
```{{exec}}

This command will automatically open a browser, but due to a limitation of `killercoda.com`, the browser cannot be opened automatically. You can use [this link]({{TRAFFIC_HOST1_8080}}) to access your application.
