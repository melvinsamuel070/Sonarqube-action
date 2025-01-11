# /bin/bash

# sonarqube installation
set -e
sudo apt-get update

sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.0.65466.zip
sudo apt install unzip
sudo unzip sonarqube-9.9.0.65466.zip -d /opt
sudo mv /opt/sonarqube-9.9.0.65466 /opt/sonarqube
sudo groupadd sonar
sudo useradd -c "user to run SonarQube" -d /opt/sonarqube -g sonar sonar
sudo chown sonar:sonar /opt/sonarqube -R

# start sonarqube
sudo /opt/sonarqube/bin/linux-x86-64/sonar.sh start

# this will update sonarqube properties with DB
sudo vim /opt/sonarqube/conf/sonar.properties
# this create a service for sonarqube
sudo vim /etc/systemd/system/sonar.service

# Start and enable the SonarQube service
sudo systemctl start sonar
sudo systemctl enable sonar
sudo systemctl status sonar
sudo tail -f /opt/sonarqube/logs/sonar.log


