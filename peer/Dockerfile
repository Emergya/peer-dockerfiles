FROM phusion/baseimage:0.9.16

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
                                         swig \
                                         apache2 \
                                         libapache2-mod-wsgi \
                                         python-dev \
                                         python-pip

RUN service apache2 stop && \
    update-rc.d apache2 disable

ADD scripts /scripts
RUN chmod +x /scripts/start.sh
RUN chmod +x /scripts/initdb.sh

RUN pip install peer

ADD config/peer.conf /etc/apache2/sites-available/peer.conf
ADD config/local_settings.py /usr/local/lib/python2.7/dist-packages/peer/local_settings.py
ADD config/apache2.conf /etc/apache2/apache2.conf

# Add daemon to be run by runit.
RUN mkdir /etc/service/peer
RUN ln -s /scripts/start.sh /etc/service/peer/run

RUN touch /firstrun

EXPOSE 80
VOLUME ["/var/log"]

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
