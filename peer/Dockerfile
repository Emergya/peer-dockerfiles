FROM debian:8.7

MAINTAINER Enrique Perez Arnaud <eperez@emergya.com>

RUN apt-get update && apt-get install -y git \
                                         libgit2-dev \
                                         inotify-tools \
                                         libxml2-dev \
                                         libxml2 \
                                         libxslt1-dev \
                                         libxslt1.1 \
                                         xmlsec1 \
                                         libxmlsec1-openssl \
                                         zlib1g-dev \
                                         python-dev \
                                         python-pip \
                                         libffi-dev \
                                         libssl-dev \
                                         postgresql-client-9.4 \
                                         postgresql-server-dev-9.4


RUN pip install -U setuptools
RUN pip install psycopg2
RUN pip install cryptography

WORKDIR /opt
RUN  git clone https://github.com/Emergya/peer.git


RUN mkdir /opt/peer/peer/local_settings
ADD config /config

VOLUME ["/opt/peer/peer/media", "/opt/peer/peer/local_settings"]

ADD config/buildout.cfg /opt/peer/buildout.cfg
ADD scripts/peer.wsgi /opt/peer/peer/peer_wsgi.py
ADD scripts/run.sh /usr/local/bin/run.sh
RUN chmod 755 /usr/local/bin/run.sh

WORKDIR /opt/peer

RUN python bootstrap.py \
  && bin/buildout

EXPOSE 8000

RUN ["touch", "/etc/firstrun"]

CMD ["/usr/local/bin/run.sh"]
