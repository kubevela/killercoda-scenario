## Visit VelaUX

RUN `vela port-forward addon-velaux -n vela-system 8080:80 --address='0.0.0.0'`{{exec}}

>Warning: `--address='0.0.0.0'` is just to adapt to the [killercoda.com](https://github.com/killercoda/scenario-examples/blob/main/network-traffic/step1.md) platform and is not a requirement!

Choose `> Cluster: local | Namespace: vela-system | Component: velaux | Kind: Service` for visit.

You can visit velaux by this dynamically rendered [endpoint]({{TRAFFIC_HOST1_8080}}).

The default username and password is: `admin` and `VelaUX12345`.

## Creating an application

Enter the page of Application on the left, and click `New Application` to create. Pick your name, alias, and description; Select type of `webservice`; Decide your environment, Default environment is already available in the first place. You could also enter the page of Environments to set up new.

Click `Next Step` so to the configuration page. You need to set up the Image address and resources limit. If you want to set up a command for the image, open up the row `CMD`.

If you want to deploy the private image, please create the registry integration configuration. refer to: [Image registry configuration](../how-to/dashboard/config/image-registry)

After inputting the Image address, the system will load the Image info from the registry. If the image belongs to the private image registry, the `Secret` field will be automatically assigned values.

You could refer to their information to configure the `Service Ports` and `Persistent Storage`.

![set webservice application](https://static.kubevela.net/images/1.4/create-webservice.jpg)

Done by clicking `Create` and then we enter the management page.

## Deploying the application

Click the `Deploy` button on the upper right and select a workflow. Note that each Environment of the application has its workflow. On the right of the `Baseline Config` tab is the environments. Check out the status of the environment and its instance information as you wish.

![webservice application env page](https://kubevela.io/assets/images/webservice-env-1eef2c1259531e395271ec3aa76412c5.jpg)

When it has several targets in this environment, you may find them all in the `Instances` list. If you want to look at the process of application deployment, click `Check the details` to reveal.

In the `Instances` list, you may find some of them are in pending status. Click `+` in the beginning to figure out the reason in more detail.

## Update image

After the first deployment, our business keeps evolving and the following updates come along.

Click `Baseline Config` and you can see the all components. Then click the component name and open the configuration page, you can update your latest requirements for image, version, and environment variable.

## Update replicas

If your business requires more than one replica, enter the `Properties` page. By default, The component has a `Set Replicas` trait. Click it so that you can update the replicas.

![set application replicas](https://kubevela.io/assets/images/set-replicas-bc40ff5b12af9100c01f79d6a846d50b.jpg)

## Upgrading the application

By twos steps as above, it is still in a draft state, we need to click the deployment button again to complete the upgrade of the application.

## Application recycling and deletion

If you need to delete the application after testing, you need to recycle all the deployed environments first. Click the environment name to enter the environment instance list, and click the `Recycle` button to recycle the deployment of the application in that environment. After it's done, the application in this environment rolls back as an undeployed one.

After all of the environments have been recycled, the application can be deleted. Currently, the entry for application deletion is on the application list page. Back to the application list page, mouse on the menu icon on the right side of the application name, and click the `Remove` option.

![delete application](https://kubevela.io/assets/images/app-delete-2040ad684a714e54065057d357229e1b.jpg)

At this point, you have basically mastered the deployment method of Docker image.

You can refer to [how to manage applications](https://kubevela.io/docs/how-to/dashboard/application/create-application) to learn the details about the UI console operations.
