### Deploy a classic application

Below is a classic KubeVela application which contains one component with one operational trait, basically, it means to deploy a container image as webservice with one replica. Additionally, there are three policies and workflow steps, it means to deploy the application into two different environments with different configurations.

```yaml
apiVersion: core.oam.dev/v1beta1
kind: Application
metadata:
  name: first-vela-app
spec:
  components:
    - name: express-server
      type: webservice
      properties:
        image: oamdev/hello-world
        ports:
         - port: 8000
           expose: true
      traits:
        - type: scaler
          properties:
            replicas: 1
  policies:
    - name: target-default
      type: topology
      properties:
        # The cluster with name local is installed the KubeVela.
        clusters: ["local"]
        namespace: "default"
    - name: target-prod
      type: topology
      properties:
        clusters: ["local"]
        # This namespace must be created before deploying.
        namespace: "prod"
    - name: deploy-ha
      type: override
      properties:
        components:
          - type: webservice
            traits:
              - type: scaler
                properties:
                  replicas: 2
  workflow:
    steps:
      - name: deploy2default
        type: deploy
        properties:
          policies: ["target-default"]
      - name: manual-approval
        type: suspend
      - name: deploy2prod
        type: deploy
        properties:
          policies: ["target-prod", "deploy-ha"]
```

* Create an environment for your first app.

`vela env init prod --namespace prod`{{exec}}

* Starting deploy the application

`vela up -f https://kubevela.net/example/applications/first-app.yaml`{{exec}}

* View the process and status of the application deploy

`vela status first-vela-app`{{exec}}

The application will become a `workflowSuspending` status, it means the workflow has finished the first two steps and waiting for manual approval as the step specified.

* Access the application

We can check the application by:

```
vela port-forward first-vela-app 8000:8000 --address='0.0.0.0'
```{{exec}}

>Warning: `--address='0.0.0.0'` is just to adapt to the [killercoda.com](https://github.com/killercoda/scenario-examples/blob/main/network-traffic/step1.md) platform and is not a requirement!

Choose `> Cluster: local | Namespace: default | Kind: Service | Name: express-server` for visit.

[visit website]({{TRAFFIC_HOST1_8000}})

It will invoke your browser and your can see the website:

```
<xmp>
Hello KubeVela! Make shipping applications more enjoyable. 

...snip...
```

* Resume the workflow

After we finshed checking the application, we can approve the workflow to continue:

```
vela workflow resume first-vela-app
```{{exec}}

Then the rest will be delivered in the `prod` namespace:

```
vela status first-vela-app
```{{exec}}

Great! You have finished deploying your first KubeVela application, you can also view and manage it in UI.

### Manage application with UI Console

> Currently, the application created by CLI is readonly in your dashboard.

After finished the installation of VelaUX, you can view and manage the application created.

* Port forward the UI if you don't have endpoint for access:

```
vela port-forward addon-velaux -n vela-system 8080:80
```{{exec}}

* Check the password by:

```
vela logs -n vela-system --name apiserver addon-velaux | grep "initialized admin username"
```{{exec}}

* Check the resources deployed

Click the application card, then you can view the details of the application.
