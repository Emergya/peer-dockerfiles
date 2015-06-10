FROM phusion/baseimage:0.9.16


MAINTAINER Enrique Perez Arnaud <enrique@cazalla.net>

RUN apt-get update && apt-get install -y \
  vim \
  sudo \
  wget \
  locales \
  build-essential \
  libreadline-dev \
  zlib1g-dev \
  libpng++-dev \
  libjpeg-dev \
  libfreetype6-dev \
  libncurses-dev \
  libbz2-dev \
  libcrypto++-dev \
  libssl-dev \
  libdb-dev \
  sqlite3 \
  libsqlite3-dev

RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales && \
    locale-gen en_US.UTF-8 && \
    /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN wget --no-check-certificate https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz \
  && tar xzf Python-2.7.10.tgz \
  && cd Python-2.7.10 \
  && ./configure \
  && make install \
  && cd .. \
  && rm -rf Python-2.7.10*

RUN wget https://bootstrap.pypa.io/ez_setup.py -O - | python

RUN easy_install pip
