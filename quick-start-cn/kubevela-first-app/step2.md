### 部署一个经典的应用程序

下面是一个经典的 KubeVela 应用程序，它包含一个 component，其中有一个 scaler trait。基本上，其就是将一个容器镜像部署为具单副本的 Web 服务。此外，还有三个 policies 和 workflow，这意味着将应用程序部署到两个不同的环境中，具有不同的配置。

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

* 创建 prod environment

`vela env init prod --namespace prod`{{exec}}

* 开始部署应用程序

`vela up -f https://kubevela.net/example/applications/first-app.yaml`{{exec}}

* 查看申请部署的进程和状态

`vela status first-vela-app`{{exec}}

该应用程序将成为 `workflowSuspending` 状态，这意味着 workflow 已经完成了前两个步骤，正在等待特定的人工审批 step。

* 访问应用程序

默认情况下，VelaUX 没有任何暴露的端口，你可以通过 `port-forward` 命令来查看它：

```
vela port-forward first-vela-app 8000:8000 --address='0.0.0.0'
```{{exec}}

> 请注意：`--address='0.0.0.0'`只是为了适应 [killercoda.com](https://github.com/killercoda/scenario-examples/blob/main/network-traffic/step1.md) 平台，这并不是必须的!

选择 `> Cluster: local | Namespace: default | Kind: Service | Name: express-server`

[访问 website]({{TRAFFIC_HOST1_8000}})

它将调用你的浏览器，你可以看到网站：

```
<xmp>
Hello KubeVela! Make shipping applications more enjoyable. 

...snip...
```

* 恢复工作流程

在完成检查后，我们可以批准工作流程继续进行：

```
vela workflow resume first-vela-app
```{{exec}}

然后其余的将在 `prod` namespace 中交付：

```
vela status first-vela-app
```{{exec}}

太棒了! 你已经完成了你的第一个 KubeVela 应用程序的部署，你可以继续在 UI 界面中查看和管理它。

### 使用 UI 控制台管理应用程序

> 目前，使用 CLI 创建的应用程序在你的仪表板上是**只读**的。

在完成 VelaUX 的安装后，你可以在 UI 界面中查看和管理创建的应用程序。

* 默认情况下，VelaUX 没有任何暴露的端口，你可以通过 `port-forward` 命令来查看它：

```
vela port-forward addon-velaux -n vela-system 8080:80
```{{exec}}

<!-- * Check the password by:

```
vela logs -n vela-system --name apiserver addon-velaux | grep "initialized admin username"
```{{exec}} -->

* 检查部署的资源

点击 `Application`，然后你可以查看 `application` 的细节。
