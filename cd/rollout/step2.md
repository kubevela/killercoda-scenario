## Visit VelaUX

> Before you start, use `ctrl` + `c` to stop the previous steps.

RUN `vela port-forward addon-velaux -n vela-system 8080:80 --address='0.0.0.0' -c velaux`{{exec}}

>Warning: `--address='0.0.0.0'` is just to adapt to the [killercoda.com](https://github.com/killercoda/scenario-examples/blob/main/network-traffic/step1.md) platform and is not a requirement!

You can visit velaux by this dynamically rendered [endpoint]({{TRAFFIC_HOST1_8080}}).

The default username and password is: `admin` and `VelaUX12345`.

> Currently killercoda does not support split screen display of pages and courses. You can follow the [official documentation](https://kubevela.io/docs/tutorials/webservice) after you have started VelaUX.

## Perform canary rollout process on VelaUX

You can also execute a Canary Rollout process on VelaUX.

### First deployment

To begin, create an application with a `webservice` component and set its image to `wangyikewyk/canarydemo:v1`, as shown in the image below:

![image](https://kubevela.io/assets/images/kruise-rollout-velaux-v1-component-7594336667aed2c4ce079f8617b92314.jpg)

Next, add a `scaler` trait for this component and set the replica number to 3, as shown below:

![image](https://kubevela.io/assets/images/kruise-rollout-velaux-v1-scaler-26f9f1cdc0ee1769f912365e0c3ee2a0.jpg)

Finally, configure a gateway for the component and set the hostname and traffic route, as illustrated in the image:

![image](https://kubevela.io/assets/images/kruise-rollout-velaux-v1-gateway-7061babf72e32f69b42fa6b5eedb3bca.jpg)

After clicking the deploy button, the application will be deployed, and you can check its status on the `resource topology` page, as shown below:

![image](https://kubevela.io/assets/images/kruise-rollout-velaux-v1-d5d57c5294624cdaef36a1b3b01e5fed.jpg)

### Day-2 Canary Release

To update the component, change the image to `wangyikewyk/canarydemo:v2`:

![image](https://kubevela.io/assets/images/kruise-rollout-velaux-v2-component-3c39157baad75d6ea479849db9f7224b.jpg)

Next, click the `deploy` button then click `Enable Canary Rollout` button to create a new canary rollout workflow, as shown below:

![image](https://kubevela.io/assets/images/kruise-rollout-velaux-enable-canary-ca457a32b94a5830f6c0e9db47470974.jpg)

Set the batches to 3 to perform a Canary Rollout of the application with 3 batches:

![image](https://kubevela.io/assets/images/kruise-rollout-velaux-batches-num-85b009284b386222c5f091a335e6c584.jpg)

You will see the new created workflow is as shown below, click the `save` button to save it.

![image](https://kubevela.io/assets/images/kruise-rollout-velaux-canary-workflow-5dd21c5d0a7fb419348b68b08cee138a.jpg)

The rollout process is divided into three steps, with each step releasing 1/3 replicas and traffic to the new version. A manual approval step is between two `canary-deploy` steps. You can also modify the weight of every Canary Rollout step.

Click deploy again and choose the `Default Canary Workflow` to begin the rollout process as shown: 

![image](https://kubevela.io/assets/images/kruise-rollout-velaux-choose-wf-f779adb0ccfea1f376ccaca2d5520cb0.jpg)

After the first step is complete, 1 replica will be updated to v2, as shown below:

![image](https://kubevela.io/assets/images/kruise-rollout-velaux-v2-batch1-edff3e3ac75689f1b153440ab792183d.jpg)

You can try to access the gateway using the following command, and you will have a 1/3 chance of getting the `Demo: V1`.

```shell
$ curl -H "Host: canary-demo.com" <ingress-controller-address>/version
Demo: V1
```

### Continue rollout

To continue the rollout process, click the `continue` button on the workflow page:

![image](https://kubevela.io/assets/images/kruise-rollout-velaux-v2-continue-87f6e057a572fef2bb0c9f1e8e454489.jpg)

You will find that 2 replicas have been updated to the new version:

![image](https://kubevela.io/assets/images/kruise-rollout-velaux-v2-batch2-49c543f8aedb2391d5eb4e223123125d.jpg)

### Rollback

To terminate the rolling process and rollback the application to version v1, click the `rollback` button:

![image](https://kubevela.io/assets/images/kruise-rollout-velaux-v2-rollback-0d207aa5e2ae2af03683040f9dbab0f0.jpg)

You will find that all replicas have been rolled back to v1:

![image](https://kubevela.io/assets/images/kruise-rollout-velaux-v1-d5d57c5294624cdaef36a1b3b01e5fed.jpg)
