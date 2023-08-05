#!/bin/bash

<<COMMENT

  Summary:
  The following code will install Java and the build tools
    Gradle and Maven. The versions are output at the end of
    the install as confirmation.

  Note: Gradle is installed with snap and assumes that snap
    is already installed.

  Instructions:
    - https://linuxize.com/post/how-to-install-apache-maven-on-ubuntu-20-04/
    - https://askubuntu.com/questions/1052131/how-to-set-maven-home-path-on-ubuntu-as-user

  Maven example:
    mvn -B archetype:generate   -DarchetypeGroupId=org.apache.maven.archetypes   -DgroupId=com.mycompany.app   -DartifactId=my-app -X

COMMENT


echo "Update for open JDK 17 (expected update for JDK 21 on 19th Sept 2023)"

# Java install
sudo apt install -y \
    openjdk-17-jdk \
    openjdk-17-jre

# Maven install: For Java 17 Maven must be version 
export MAVEN_VERSION=3.9.2
sudo wget https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz -P /tmp
sudo tar xf /tmp/apache-maven-*.tar.gz -C /opt
sudo ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven

# Gradle install
# sudo snap install gradle --classic
# https://linuxhint.com/installing_gradle_ubuntu/
export GRADLE_VERSION=8.1.1
wget -c https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -P /tmp
ls /tmp
sudo unzip -d /opt/gradle /tmp/gradle-${GRADLE_VERSION}-bin.zip
ls /opt/gradle

# Setup gradle executeable
echo "export GRADLE_HOME=/opt/gradle/gradle-${GRADLE_VERSION}" >> gradle.sh
echo 'export PATH=${GRADLE_HOME}/bin:${PATH}' >> gradle.sh
sudo mv gradle.sh /etc/profile.d/gradle.sh
sudo chmod +x /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh
echo "source /etc/profile.d/gradle.sh" >> ~/.bashrc

# Add JAVA_HOME
echo "export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64" >> ~/.bashrc
source ~/.bashrc
echo 'export PATH=${JAVA_HOME}/bin:${PATH}' >> ~/.bashrc
source ~/.bashrc

# Add Maven Home
echo 'export M2_HOME=/opt/maven' >> ~/.bashrc
echo 'export MAVEN_HOME=/opt/maven' >> ~/.bashrc
source ~/.bashrc
echo 'export PATH=${M2_HOME}/bin:${PATH}' >> ~/.bashrc
source ~/.bashrc


# Check versions
java --version
mvn -version
gradle -v
