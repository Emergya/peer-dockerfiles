FROM ubuntu:14.04.2

MAINTAINER Enrique Perez Arnaud <eperez@emergya.com>

RUN apt-get update && apt-get install -y git \
                                         inotify-tools \
                                         libxml2-dev \
                                         libxml2 \
                                         libxslt1-dev \
                                         libxslt1.1 \
                                         xmlsec1 \
                                         libxmlsec1-openssl \
                                         python-dev \
                                         python-pip

ADD scripts /scripts
RUN chmod +x /scripts/start.sh

RUN pip install gunicorn
RUN pip install peer

ADD config/local_settings.py /usr/local/lib/python2.7/dist-packages/peer/local_settings.py

WORKDIR /usr/local/lib/python2.7/dist-packages/peer

RUN touch /firstrun

EXPOSE 8000
VOLUME ["/var/log", "/data"]

CMD ["gunicorn peer.wsgi"]
