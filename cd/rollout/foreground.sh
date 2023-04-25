# echo "Installing scenario..."
# while [ ! -f webservice-app.yaml ]; do sleep 1; done
# echo DONE

echo "Installing KubeVela..."
curl -fsSl https://kubevela.io/script/install.sh | bash -s 1.8.0
vela install -y
echo DONE

echo "Installing VelaUX..."
vela addon enable velaux --version v1.8.0
vela addon enable fluxcd -y
vela addon enable ingress-nginx serviceType=NodePort -y
echo DONE