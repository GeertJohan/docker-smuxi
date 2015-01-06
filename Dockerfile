# Builds a docker image for smuxi
FROM ubuntu:trusty
MAINTAINER Carlos Hernandez <carlos@techbyte.ca>

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Set locale to UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
RUN locale-gen en_US en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
RUN dpkg-reconfigure locales

# Set user nobody to uid and gid of unRAID, uncomment for unRAID
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody
RUN usermod -s /bin/bash nobody

# Update ubuntu
RUN apt-mark hold initscripts udev plymouth mountall;\
    echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/90forceyes;\
    echo 'deb http://archive.ubuntu.com/ubuntu trusty main universe restricted' > /etc/apt/sources.list;\
    echo 'deb http://archive.ubuntu.com/ubuntu trusty-updates  main universe restricted' >> /etc/apt/sources.list;\
    apt-get update;\
    echo exit 101 > /usr/sbin/policy-rc.d && chmod +x /usr/sbin/policy-rc.d;\
    dpkg-divert --local --rename --add /sbin/initctl;\
    ln -sf /bin/true /sbin/initctl;\
    apt-get -y upgrade && apt-get clean

# Install smuxi from apt 
RUN usermod -m -d /config nobody
RUN apt-get install -qy --force-yes smuxi-engine


ADD ./start.sh /start.sh
RUN chmod a+x  /start.sh

VOLUME /config

# DON'T RUN AS ROOT
USER nobody
ENTRYPOINT ["/start.sh"]
