# # /bin/bash

# # sonarqube installation
# set -e
# sudo apt-get update

# sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.0.65466.zip
# sudo apt install unzip
# sudo unzip sonarqube-9.9.0.65466.zip -d /opt
# sudo mv /opt/sonarqube-9.9.0.65466 /opt/sonarqube
# sudo groupadd sonar
# sudo useradd -c "user to run SonarQube" -d /opt/sonarqube -g sonar sonar
# sudo chown sonar:sonar /opt/sonarqube -R

# # start sonarqube
# sudo /opt/sonarqube/bin/linux-x86-64/sonar.sh start

# # this will update sonarqube properties with DB
# sudo vim /opt/sonarqube/conf/sonar.properties
# # this create a service for sonarqube
# sudo vim /etc/systemd/system/sonar.service

# # Start and enable the SonarQube service
# sudo systemctl start sonar
# sudo systemctl enable sonar
# sudo systemctl status sonar
# sudo tail -f /opt/sonarqube/logs/sonar.log




#!/bin/bash

# Enable exit on error
set -e

# Update and install necessary dependencies
sudo apt-get update
sudo apt install -y wget unzip

# Define SonarQube version
SONARQUBE_VERSION="9.9.0.65466"

# Download and unzip SonarQube
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-${SONARQUBE_VERSION}.zip
sudo unzip sonarqube-${SONARQUBE_VERSION}.zip -d /opt
sudo mv /opt/sonarqube-${SONARQUBE_VERSION} /opt/sonarqube

# Create user and group for SonarQube
sudo groupadd sonar || true  # Prevent error if the group already exists
sudo useradd -c "user to run SonarQube" -d /opt/sonarqube -g sonar sonar || true  # Prevent error if the user already exists
sudo chown sonar:sonar /opt/sonarqube -R

# Update SonarQube properties for database (example for DB configuration)
sudo sed -i 's|#sonar.jdbc.url=|sonar.jdbc.url=jdbc:mysql://localhost:3306/sonar|' /opt/sonarqube/conf/sonar.properties
sudo sed -i 's|#sonar.jdbc.username=|sonar.jdbc.username=sonar|' /opt/sonarqube/conf/sonar.properties
sudo sed -i 's|#sonar.jdbc.password=|sonar.jdbc.password=password|' /opt/sonarqube/conf/sonar.properties

# Create a systemd service for SonarQube
sudo bash -c 'cat << EOF > /etc/systemd/system/sonar.service
[Unit]
Description=SonarQube Service
After=network.target

[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
User=sonar
Group=sonar
LimitNOFILE=65536
TimeoutStartSec=5min

[Install]
WantedBy=multi-user.target
EOF'

# Reload systemd and enable SonarQube service
sudo systemctl daemon-reload
sudo systemctl start sonar
sudo systemctl enable sonar
sudo systemctl status sonar

# Display SonarQube logs
sudo tail -f /opt/sonarqube/logs/sonar.log

echo "SonarQube installation completed successfully."