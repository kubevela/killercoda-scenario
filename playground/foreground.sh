echo "Installing KubeVela..."
curl -fsSl https://kubevela.io/script/install.sh | bash -s 1.8.0
vela install -y
echo DONE

echo "Installing VelaUX..."
vela addon enable velaux --version v1.8.0
echo DONE