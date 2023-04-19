## Install VelaUX

VelaUX is a dashboard including UI+API services, it enables you to do everything around application delivery and management.
VelaUX isn't required for KubeVela, but it is an excellent entry to get started.

VelaD has prepared all VelaUX resources (images, addon manifests) for you. Just like it hints when `velad install`, you can enable VelaUX by:

```
vela addon enable /root/.vela/addons/velaux
```{{exec}}

Here, you have to replace <user> with your own username. 

To use dashboard, get the admin password first, `2oxg13aefu` is the password in this case.

> Since v1.4.0, initial password for admin will be fixed.

```
vela logs -n vela-system --name apiserver addon-velaux | grep "initialized admin username"
```{{exec}}

```text
apiserver-97cfbd6f9-h854b apiserver 2022-05-26T08:14:01.279764100Z {"level":"info","ts":1653552841.27872,"caller":"usecase/user.go:109","msg":"initialized admin username and password: admin / 2oxg13aefu\n"}
```

Do as the output says, port-forward velaux and choose "Cluster: local | Namespace: vela-system | Kind: Service | Name: velaux"

```
vela port-forward -n vela-system addon-velaux 9082:80 --address='0.0.0.0'
```{{exec}}

🎉 Congrats! You have successfully installed VelaUX.

Now access velaux using this link:

[ACCESS VELAUX]({{TRAFFIC_HOST1_9082}})

It's also possible to access ports using the top-right navigation in the terminal.

Or we can display the link to that page:

[ACCESS PORTS]({{TRAFFIC_SELECTOR}})