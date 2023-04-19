### Install KubeVela CLI

This is quite easy. Depends on your system, run one of scripts below.

RUN `curl -fsSl https://kubevela.io/script/install.sh | bash -s 1.7.6`{{exec}}

After install, you can run `vela version` to check vela CLI installed

RUN `vela version`{{exec}}

### Install KubeVela Core

RUN `vela install`{{exec}}

### Install VelaUX

RUN `vela addon enable velaux --version v1.7.6`{{exec}}

By default, velaux didn't have any exposed port, you can view it by:

`vela port-forward addon-velaux -n vela-system 8080:80 --address='0.0.0.0'`{{exec}}

>Warning: `--address='0.0.0.0'` is just to adapt to the [killercoda.com](https://github.com/killercoda/scenario-examples/blob/main/network-traffic/step1.md) platform and is not a requirement!

Choose `> Cluster: local | Namespace: vela-system | Component: velaux | Kind: Service` for visit.

You can visit velaux by this dynamically rendered [endpoint]({{TRAFFIC_HOST1_8080}}).

The default username and password is: `admin` and `VelaUX12345`.