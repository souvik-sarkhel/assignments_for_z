#This command downloads the 
FROM centos:6
MAINTAINER Souvik Sarkhel <souvik.sarkhel@gmail.com>

USER root
# update and patch the the base image that has been downloaded
RUN yum -y update

# Since the centos image that is downloaded is a base image install base packages
RUN yum -y groupinstall "Development Tools" && \
    yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel && \
    yum -y install wget tar && \
    yum -y install erlang gcc gcc-c++ kernel-devel-`uname -r` make perl sqlite-devel && \
    yum -y install bzip2 bzip2-devel zlib-devel && \
    yum -y install ncurses-devel readline-devel tk-devel && \
    yum -y install net-tools nfs-utils openssl-devel && \
    yum -y install git screen tmux wget zsh
	
#Install commands for Python 2.7
#First download the Python tar file from the internet
#then untar the Python tar file
#goto the folder named Python-2.7.6
#then next commands are to compile and install Python
#It is important to use altinstall instead of install,
#otherwise you will end up with two different versions of Python in the filesystem both named python.
RUN cd /opt && \
    wget --no-check-certificate https://www.python.org/ftp/python/2.7.6/Python-2.7.6.tar.xz && \
    tar xf Python-2.7.6.tar.xz && \
    cd Python-2.7.6 && \
    ./configure --prefix=/usr/local && \
    make && \
    make altinstall

#Create a mongodb repo file so that one can install the mongo through yum command
RUN echo " " >> /etc/yum.repos.d/mongodb.repo && \
    echo "[mongodb-org-3.2]" >> /etc/yum.repos.d/mongodb.repo && \
    echo "name=MongoDB Repository" >> /etc/yum.repos.d/mongodb.repo && \
    echo "baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/3.2/x86_64/" >> /etc/yum.repos.d/mongodb.repo && \
    echo "gpgcheck=1" >> /etc/yum.repos.d/mongodb.repo && \
    echo "enabled=1" >> /etc/yum.repos.d/mongodb.repo && \
    echo "gpgkey=https://www.mongodb.org/static/pgp/server-3.2.asc" >> /etc/yum.repos.d/mongodb.repo

#Installing mongodb-org-server,mongodb-org-mongos,mongodb-org-shell & mongodb-org-tools	using the metapackage mongodb-org
RUN yum -y install mongodb-org

# Create the MongoDB data directory
RUN mkdir -p /data/db

#Install OpenJDK-7 because tomact needs Java
RUN yum -y install java-1.7.0-openjdk

#Defining java environment variables to that the command java runs
ENV JAVA_HOME /usr/lib/jvm/jre-1.7.0-openjdk.x86_64
ENV PATH $PATH:$JAVA_HOME/bin

RUN echo "export JAVA_HOME=/usr/lib/jvm/jre-1.7.0-openjdk.x86_64" >> ~/.bashrc && \
    echo "PATH=$PATH:$JAVA_HOME/bin" >> ~/.bashrc && \
    source ~/.bashrc
#Download and untar the Apache Tomcat 7 into /usr/share and give 755 permission
RUN cd /usr/share && \
    wget http://www-eu.apache.org/dist/tomcat/tomcat-7/v7.0.73/bin/apache-tomcat-7.0.73.tar.gz && \
    mkdir tomcat && \
    tar -zxf apache-tomcat-7.0.73.tar.gz -C /usr/share/tomcat --strip-components=1 && \
	chown 755 -R /usr/share/tomcat
	
ENV TOMCAT_HOME /usr/share/tomcat

RUN /usr/share/tomcat/bin/startup.sh	
# Expose port #27017 for MongoDB and #8080 for Apache Tomcat from the container to the host
EXPOSE 22 8080 27017 

# Set /usr/bin/mongod as the dockerized entry-point application
#ENTRYPOINT ["/usr/bin/mongod"]
#ENTRYPOINT ["/usr/share/tomcat/bin/startup.sh"]


