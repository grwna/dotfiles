#!/bin/bash
set -e

echo "Isolating Native Docker socket from Docker Desktop..."
sudo mkdir -p /etc/systemd/system/docker.socket.d
cat <<EOF | sudo tee /etc/systemd/system/docker.socket.d/override.conf > /dev/null
[Socket]
ListenStream=
ListenStream=/var/run/docker-native.sock
EOF

echo "Reloading systemd and starting Native Docker..."
sudo systemctl daemon-reload
sudo systemctl restart docker.socket docker
sudo systemctl enable docker.socket docker

echo "Configuring Docker contexts..."
# Create native-wsl if it doesn't exist, update it if it does
docker context create native-wsl --docker "host=unix:///var/run/docker-native.sock" 2>/dev/null || \
docker context update native-wsl --docker "host=unix:///var/run/docker-native.sock"

docker context create desktop-wsl --docker "host=unix:///var/run/docker.sock" 2>/dev/null || \
docker context update desktop-wsl --docker "host=unix:///var/run/docker.sock"

echo "Native WSL setup complete."
