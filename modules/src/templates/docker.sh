#!/usr/bin/env bash
sudo yum update -y
sudo amazon-linux-extras install docker
sudo service docker start
sudo systemctl enable docker
sudo usermod -a -G docker ec2-user

echo "Installing dunnhumby systemd service..."

echo '
[Unit]
Description=dunnhumby hellow world container
After=docker.service
Wants=network-online.target docker.socket
Requires=docker.socket

[Service]
Restart=on-failure
ExecStartPre=/usr/bin/docker pull tutum/hello-world
ExecStart=/usr/bin/docker run -p 127.0.0.1:8080:80 tutum/hello-world
ExecStop=/usr/bin/docker stop -t 10 tutum/hello-world

[Install]
WantedBy=multi-user.target' > /root/dunnhumby.service

# Set up systemd
sudo cp /root/dunnhumby.service /etc/systemd/system/dunnhumby.service
sudo chown root:root /root/dunnhumby.service
sudo mv /root/dunnhumby.service /etc/systemd/system/dunnhumby.service
sudo chmod 0644 /etc/systemd/system/dunnhumby.service

# enable & reload
sudo systemctl enable dunnhumby.service
sudo systemctl daemon-reload


echo "Starting dunnhumby-hello-world"
sudo systemctl restart dunnhumby.service
