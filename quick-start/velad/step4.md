## Deliver your first app

Now we'll use VelaUX to deliver your first app, just a Nginx for example.
Notice that this example may be simple. However, you can use the same pattern to deliver more complicated app depends on your stack.

1. Click the **New Application** in top-right of window.
2. Input **first-app** for **Name** and choose **Default(default)** for **Bind Environments**. Click **Next Step**.
3. Input `nginx` for **Container Image**. Click **Create**
4. Click **first-app** in components panel
5. Click the plus button in Traits panel. we'll add a gateway trait, so we can access it from localhost
6. In the detail form, first choose **gateway** in **Type**. Arguments will show below. Then fill two arguments
  - Change **Class** to `traefik` to use Traefik packed with VelaD.
  - Add a route rule from `/` to `80`, which we'll use localhost:port without sub-path to access port 80 inside.
  - Click the **Create** to add gateway trait to this app.
7. Finally, we can click the **Deploy** button in the right-top of window. This will launch app to K8s Cluster where
   KubeVela runs.

After seven steps. You can check the application healthiness in `Default` tab. When it is running, we can access it with
`127.0.0.1:8080`. That was mentioned when velad install.
