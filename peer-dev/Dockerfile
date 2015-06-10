FROM peer/python:2.7.10

MAINTAINER Enrique Perez Arnaud <eperez@emergya.com>

RUN apt-get update && apt-get install -y postgresql-server-dev-9.3 \
                                         postgresql-client \
                                         git \
                                         inotify-tools \
                                         libxml2-dev \
                                         libxml2 \
                                         libxslt1-dev \
                                         libxslt1.1 \
                                         xmlsec1 \
                                         libxmlsec1-openssl \
                                         libpq-dev \
                                         libffi-dev \
                                         swig

ADD scripts /scripts
RUN chmod +x /scripts/start.sh
RUN chmod +x /scripts/initdb.sh

WORKDIR /opt

RUN  git clone https://github.com/Emergya/peer.git

# Expose settings in the host.
ADD config/local_settings.py /opt/peer/peer/local_settings.py
ADD config/buildout.cfg /opt/peer/buildout.cfg

WORKDIR /opt/peer

RUN python bootstrap.py \
  && bin/buildout

# Add daemon to be run by runit.
RUN mkdir /etc/service/peer
RUN ln -s /scripts/start.sh /etc/service/peer/run

RUN touch /firstrun

# Expose our data, log, and configuration directories.
# VOLUME ["/opt/peer"]

EXPOSE 8080

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
