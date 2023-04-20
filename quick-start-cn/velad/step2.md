## 试用 VelaD 设置 KubeVela

你只需要运行 `velad install`，它将帮助你完成以下工作：

1. 启动一个 KubeVela 需要的集群
2. 在集群中安装 KubeVela
3. 在机器上安装 vela CLI
4. 放置 VelaUX（一个网络面板插件）资源

```shell
velad install
```{{exec}}

> 注意：之后我们将使用 gateway trait。记住我们可以使用 127.0.0.1:8080 来访问具有 gateway trait 的应用程序。
现在你在这台机器已经有了 KubeVela。为了验证安装结果，检查工具和资源是否准备就绪、
运行 `velad status`。

RUN 
```
velad status
```{{exec}}

现在你可以使用 vela CLI 了。尝试检查所有可用的组件类型。以后我们在部署第一个应用程序时将使用 `webservice` 类型的组件。

### 验证安装

```
export KUBECONFIG=$(velad kubeconfig --host)
vela comp
```{{exec}}
