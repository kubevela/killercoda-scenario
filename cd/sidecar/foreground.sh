echo "Installing KubeVela..."
curl -fsSl https://kubevela.io/script/install.sh | bash -s 1.7.6
vela install -y
echo DONE
