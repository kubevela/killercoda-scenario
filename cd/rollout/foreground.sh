# echo "Installing scenario..."
# while [ ! -f webservice-app.yaml ]; do sleep 1; done
# echo DONE

echo "Installing KubeVela..."
curl -fsSl https://kubevela.io/script/install.sh | bash -s 1.7.6
vela install -y
echo DONE

echo "Installing VelaUX..."
vela addon enable velaux --version v1.7.6
vela addon enable ingress-nginx serviceType=NodePort
echo DONE