
#dockerizing MongoDB: Dockerfile for building MongoDB images
# Based on ubuntu:latest, installs MongoDB following the instructions from:
# http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/

#FROM       ubuntu:16.04
#FROM centos:7
FROM base-centos7
#ENV container docker
#MAINTAINER Docker

# Avocado installation
#ADD   avocado_2.0.51_amd64.deb /
ADD avocado-2.0.57-1.x86_64.rpm /usr
ADD install_adpl.sh /usr

RUN yum -y update
#RUN ./install_adpl.sh -i -o  192.168.100.141 -p /avocado_2.0.51_amd64.deb  -f -m
RUN /usr/install_adpl.sh -i -o  192.168.100.141 -p /usr/avocado-2.0.57-1.x86_64.rpm  -f -m
#RUN sed "/^.*orchestrator.*$/d" /etc/hosts > /etc/hosts.new; echo "192.168.100.141   orchestrator " >> /etc/hosts.new; cp /etc/hosts.new /etc/hosts
#RUN sed "/^.*orchestrator.*$/d" /etc/hosts > /etc/hosts.new && echo "192.168.100.141   orchestrator" >> /etc/hosts.new && /bin/cp -f  /etc/hosts.new /etc/hosts

RUN sed 's/1000/10/g' /usr/avcd/config/appmgr.conf > /usr/avcd/config/appmgr.mod && mv /usr/avcd/config/appmgr.mod /usr/avcd/config/appmgr.conf

#RUN echo '192.168.100.141   orchestrator' >>  /etc/hosts

#Enabling ADPL
#RUN ./usr/avcd/bin/whitelist -p /usr/bin/mongod
#RUN ./usr/avcd/bin/avcd_protect enable

EXPOSE 27017
ENV HOST_INFO=192.168.100.151:4243

# Set /usr/bin/mongod as the dockerized entry-point application
#ENTRYPOINT ["./mongoserver.sh"]
CMD ["/bin/sleep", "10000"]
