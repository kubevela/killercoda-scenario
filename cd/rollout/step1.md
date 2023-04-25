## Before starting

Enable [`kruise-rollout`](https://kubevela.io/docs/reference/addons/kruise-rollout) addon, our canary rollout capability relies on the [rollouts from OpenKruise](https://github.com/openkruise/rollouts).

```
vela addon enable kruise-rollout
```{{exec}}

## First Time Deploy

> Also you can find the sample file in `filesystem` -> `canary-demo-v1.yaml` on the IDE Editor.

RUN `vela up -f /canary-demo-v1.yaml`{{exec}}

The first deployment is a default way to deploy an application. You can check the status of the application to ensure it's running before proceeding to the next step.

RUN `vela status canary-demo`{{exec}}

```shell
About:

  Name:         canary-demo                  
  Namespace:    default                      
  Created at:   2023-04-10 14:27:58 +0800 CST
  Status:       running                      

Workflow:

  mode: DAG-DAG
  finished: true
  Suspend: false
  Terminated: false
  Steps
  - id: c1cqamr5w6
    name: canary-demo
    type: apply-component
    phase: succeeded 

Services:

  - Name: canary-demo  
    Cluster: local  Namespace: default
    Type: webservice
    Healthy Ready:5/5
    Traits:
      ✅ scaler      ✅ gateway: No loadBalancer found, visiting by using 'vela port-forward canary-demo'
```

If you have enabled [velaux](https://kubevela.io/zh/docs/reference/addons/velaux) addon, you can view the application topology graph that all `v1` pods are ready now.

> RUN `vela port-forward addon-velaux -n vela-system 8080:80 --address='0.0.0.0' -c velaux`{{exec}} and visit velaux in this [URL]({{TRAFFIC_HOST1_8080}}).

![image](https://kubevela.io/zh/assets/images/kruise-rollout-v1-f4145e9ba5d3ce683a6594796cc1591a.jpg)

## Day-2 Canary Release

Let's modify the image tag of the component, from `v1` to `v2` as follows:

RUN `vela up -f /canary-demo-v2.yaml`{{exec}}

As we can see, in this update, we have also configured a canary-deploy workflow. This workflow includes 5 steps and splits the entire process into 3 stages.
Here's an **overview about what will happen** of the three stages:

1. In the first stage, the deployment will be updated with 20% of the total replicas. In our example, since we have a total of 5 replicas, 1 replica will be updated to the new version and serve 20% of the traffic. The upgrade process will then wait for a manual approval before moving on to the next stage.
2. Once the first stage has been approved, the second stage will begin. During this stage, 50% of the total replicas will be updated to the new version. In our example, this means that 2.5 replicas will be updated, which is rounded up to 3. These 3 replicas will serve 50% of the traffic, and the upgrade process will once again wait for a manual approval before moving on to the final stage.
3. In the final stage, all replicas will be updated to the new version and serve 100% of the traffic

Check the status of the application:

RUN `vela status canary-demo`{{exec}}

```shell
About:

  Name:         canary-demo                  
  Namespace:    default                      
  Created at:   2023-04-10 15:10:56 +0800 CST
  Status:       workflowSuspending           

Workflow:

  mode: StepByStep-DAG
  finished: false
  Suspend: true
  Terminated: false
  Steps
  - id: hqhtsm949f
    name: rollout-20
    type: canary-deploy
    phase: succeeded 
  - id: umzd2xain9
    name: suspend-1st
    type: suspend
    phase: suspending 
    message: Suspended by field suspend

Services:

  - Name: canary-demo  
    Cluster: local  Namespace: default
    Type: webservice
    Healthy Ready:5/5
    Traits:
      ✅ rolling-release: workload deployment is completed      ✅ scaler      ✅ gateway: Visiting URL: canary-demo.com, IP: 192.168.9.103
  - Name: canary-demo  
    Cluster: local  Namespace: default
    Type: webservice
    Healthy Ready:5/5
    Traits:
      ✅ scaler      ✅ gateway: No loadBalancer found, visiting by using 'vela port-forward canary-demo'
```

The application's status is currently set to workflowSuspending, which means that the first step has been completed and the workflow is now waiting for manual approval.

View the topology graph again to confirm that a new v2 pod has been created to serve canary traffic. Meanwhile, the remaining 4 v1 pods are still running and serving non-canary traffic.

![image](https://kubevela.io/zh/assets/images/kruise-rollout-v2-2d5647e61d936f36395953dcfc730abd.jpg)

## Continue Canary Process

After verify the success of the canary version through business-related metrics, such as logs, metrics, and other means, you can `resume` the workflow to continue the process of rollout.

RUN `vela workflow resume canary-demo`{{exec}}

Access the gateway endpoint again multi times. You will find out the chance (`50%`) to meet result `Demo: v2` is highly increased.

```shell
$ curl -H "Host: canary-demo.com" <ingress-controller-address>/version
Demo: V2
```

View topology graph again, you will see the workload updated 3 replicas to `v2`, and this pod will serve the canary traffic. Meanwhile, 2 pods of `v1` are still running and server non-canary traffic.

![image](https://kubevela.io/assets/images/kruise-rollout-v2-batch2-7b487a204924ec39a83f5970aafcbbac.jpg)

## Canary validation succeed, finished the release

In the end, you can resume again to finish the rollout process.

RUN `vela workflow resume canary-demo`{{exec}}

Access the gateway endpoint again multi times. You will find out the result always is `Demo: v2`.

```shell
$ curl -H "Host: canary-demo.com" <ingress-controller-address>/version
Demo: V2
```

## Canary verification failed, rollback the release

If you want to cancel the rollout process and rollback the application to the latest version, after manually check. You can rollback the rollout workflow:

RUN `vela workflow rollback canary-demo`{{exec}}

```shell
Application spec rollback successfully.
Application status rollback successfully.
Successfully rollback rolloutApplication outdated revision cleaned up.
```

Access the gateway endpoint again. You can see the result is always `Demo: V1`.

```shell
$ curl -H "Host: canary-demo.com" <ingress-controller-address>/version
Demo: V1
```

Any rollback operation in middle of a runningWorkflow will rollback to the latest succeeded revision of this application. So, if you deploy a successful `v1` and upgrade to `v2`, but this version didn't succeed while you continue to upgrade to `v3`. The rollback of `v3` will automatically to `v1`, because release `v2` is not a succeeded one.
