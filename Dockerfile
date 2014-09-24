# Builds a docker image for smuxi
FROM ubuntu:trusty
MAINTAINER Carlos Hernandez <carlos@techbyte.ca>

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Set user nobody to uid and gid of unRAID
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody

# Set locale
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
RUN locale-gen en_US en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
RUN dpkg-reconfigure locales

# Update Ubuntu
RUN apt-get -q update
RUN apt-mark hold initscripts udev plymouth mountall
RUN apt-get -qy --force-yes dist-upgrade

# Install smuxi from apt 
RUN usermod -m -d /config nobody
RUN apt-get install -qy --force-yes smuxi-engine

ADD ./start.sh /start.sh
ADD ./creds.conf /creds.conf
RUN chmod a+x  /start.sh

VOLUME /config

# DON'T RUN AS ROOT
USER nobody
ENTRYPOINT ["/start.sh"]
