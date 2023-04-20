### 安装 VelaUX

运行以下命令，其中 `--version v1.7.6` 可以改为指定版本。

RUN `vela addon enable velaux --version v1.7.6`{{exec}}

在默认情况下，VelaUX 没有任何暴露的端口，你可以通过 `port-forward` 命令来查看它：

`vela port-forward addon-velaux -n vela-system 8080:80 --address='0.0.0.0'`{{exec}}

> 请注意：`--address='0.0.0.0'`只是为了适应 [killercoda.com](https://github.com/killercoda/scenario-examples/blob/main/network-traffic/step1.md) 平台，这并不是必须的!

选择 `> Cluster: local | Namespace: vela-system | Component: velaux | Kind: Service`

现在你就可以通过这个链接 [endpoint]({{TRAFFIC_HOST1_8080}}) 访问 VelaUX 页面了。

默认的用户名/密码为：`admin` 和 `VelaUX12345`。
