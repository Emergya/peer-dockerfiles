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
                                         postgresql-server-dev-9.4

RUN pip install gunicorn
RUN pip install peer==0.19.0

VOLUME ["/data", "/usr/local/lib/python2.7/dist-packages/peer/static", "/usr/local/lib/python2.7/dist-packages/peer/media"]

ADD config/local_settings.py /usr/local/lib/python2.7/dist-packages/peer/local_settings.py
ADD config/gunicorn.py /etc/gunicorn.py

ADD scripts/peer.wsgi /usr/local/lib/python2.7/dist-packages/peer/peer_wsgi.py
ADD scripts/run.sh /usr/local/bin/run.sh
RUN chmod 755 /usr/local/bin/run.sh

WORKDIR /usr/local/lib/python2.7/dist-packages/peer

EXPOSE 8000

RUN ["touch", "/etc/firstrun"]

CMD ["/usr/local/bin/run.sh"]
