PEER Dockerfiles
################

Docker environments for PEER.

Dependencies
++++++++++++

Docker
------

`Docker <https://www.docker.com/>`_ is needed to run this sowftware.
On ubuntu, just run::

  $ sudo apt-get install docker.io

Fig
---

`Fig <http://www.fig.sh/>`_ is also needed. Fig is a tool to compose docker
environments consisting of more than one container. Fig has recently been
integrated into Docker's official distribution as
`docker-compose <http://docs.docker.com/compose/>`_, so as soon as
docker-compose reaches linux distributions from upstream, it will be possible
to use it on the unmodified fig config files.

A simple and safe way to get Fig is to install it in a virtualenv::

  $ sudo apt-get install python-virtualenv
  $ virtualenv fig
  $ source fig/bin/activate
  (fig)$ pip install fig

Remember to activate the virtualenv to use fig::

  $ source fig/bin/activate
  (fig)$ fig up
  ...

Usage
+++++

Get the software
----------------

The sources for this project are kept in a public repository in github. You
can either clone the repository with git::

  $ git clone https://github.com/Emergya/peer-dockerfiles.git

Or download a compressed copy::

  $ wget https://github.com/Emergya/peer-dockerfiles/archive/v0.1.zip

Initialization
--------------

Before starting our environments, we need to create a couple of intermediate
docker images. There is a simple script for this::

  $ cd /path/to/peer-dockerfiles
  $ bash initialize.sh

Note: In case the user running these commands is not in the docker group,
it may be necessary to use sudo to execute them.

Starting a development environment
----------------------------------

To start a development environment, enter in a terminal::

  $ cd /path/to/peer-dockerfiles
  $ source /path/to/fig-virtualenv/bin/activate
  $ fig -f fig-dev.yml up

This ends up with a development server listening on the host, on
localhost:8080. Apache logs, and pg data files can be
accessed from the host machine at ``dev-env/`` on the peer-dockerfiles
directory.

Starting a Production environment
---------------------------------

To start a production environment, enter in a terminal::

  $ cd /path/to/peer-dockerfiles
  $ source /path/to/fig/bin/activate
  $ fig up

This ends up with an apache server running on localhost:80. Apache logs
and pg data files can be accessed from the host machine at
``prod-env/`` on the peer-dockerfiles directory.

Configuration
+++++++++++++

Image configuration for the development environment
---------------------------------------------------

Before building the docker images for the development environment, it is
possible to edit the configuration for django in
``peer-dev/config/local_settings.py``. If there is need to modify the
configuration after building the images, they have to be deleted with
``docker rmi <images>``, and rebuilt.

Image configuration for the production environment
--------------------------------------------------

Before building the docker images for the production environment, it is
possible to edit the configuration for apache and django. The configuration
for django is in ``peer-dev/config/local_settings.py``. The general
configuration for apache is in ``peer-dev/config/apache2.conf``, and the
configuration for the apache virtual host is in ``peer-dev/config/peer.conf``.
    
If there is need to modify the configuration after building the images, they
have to be deleted with ``docker rmi <images>``, and rebuilt.

Image configuration for PostgreSQL
----------------------------------

It is possible to modify the PostgreSQL config files befor building the
postgresql image, by editing ``postgresql/etc/pg_hba.conf`` and
``postgresql/etc/postgresql.conf``.
If they are modified after building the image, the image has to be dropped and
rebuilt.

Guest data and logs
+++++++++++++++++++

Some of the data generated in the guest environments is exposed in the host.
The development environment creates a directory ``dev-env`` in the host for
this purpose, and likewise the production environment creates a ``prod-env``
directory.

Development environment
-----------------------

The development environment exposes PostgreSQL data at ``dev-env/data/``, where
it is persisted even if the postgresql container is stopped or deleted.
The data managed by git can also be found at ``dev-env/media/``.
PostgreSQL logs are exposed at at ``dev-env/pg_logs/``. The django logs are
also exposed at ``dev-env/dj_logs/``.

Production environment
----------------------

The production environment exposes PostgreSQL data at ``prod-env/data/``, and
PostgreSQL logs at ``prod-env/pg_logs/``. Apache logs can be found at
``prod-env/ap_logs/``.  The data managed by git can also be found at
``prod-env/media/``.


Reusing previous data
---------------------

If there was a previous peer installation and it is necessary to reuse its
data, we have to edit the Fig config files (fig-dev.yml or fig.yml). In the
``volumes`` section of the ``pgdata`` container, we have to change (if we are
using the development environment; if we are using the production environment,
substitute dev-env with prod-env) ``dev-env/data:/data`` to
``dev-env/data:/path/to/old/pg/datadir``. The same applies to git data: We
would have to change the volume in the ``gitdata`` section from
``dev-env/data:/data`` to ``dev-env/media:/path/to/old/peer/media``.

Sources in the development environment
--------------------------------------

It is possible to mount in the peer container the sources for PEER from the
host machine, so that they can be edited in the host and tested in the
container. To do this, it is necessary to add, in the volumes section of the
peerdev container definition in ``fig-dev.yml``, a line like::

  - /host/path/to/peer:/opt/peer

Also, this line can be removed from that section::

  - dev-env/dj_logs:/opt/peer/var/log

Be aware that the django settings file at ``/host/path/to/peer`` will override
the one added during `Image configuration for the development environment`_.
