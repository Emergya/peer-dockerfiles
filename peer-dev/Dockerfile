FROM debian:8.1

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
                                         postgresql-server-dev-9.4

WORKDIR /opt
RUN  git clone https://github.com/Emergya/peer.git

VOLUME ["/data", "/opt/peer/peer"]

# Expose settings in the host.
ADD config/buildout.cfg /opt/peer/buildout.cfg
ADD scripts/run.sh /usr/local/bin/run.sh
RUN chmod 755 /usr/local/bin/run.sh

WORKDIR /opt/peer

RUN pip install -U setuptools
RUN pip install "cryptography >= 0.7, < 1.0"
RUN python bootstrap.py \
  && bin/buildout

EXPOSE 8080

RUN ["touch", "/opt/peer/firstrun"]

CMD ["/usr/local/bin/run.sh"]
