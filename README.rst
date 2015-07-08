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

Docker-compose
--------------

`docker-compose <http://docs.docker.com/compose/>`_ is also needed.
Docker-compose is a tool to compose environments consisting one
or more containers.

A simple and safe way to get docker-compose is to install it in a virtualenv::

  $ sudo apt-get install python-virtualenv
  $ virtualenv compose
  $ source compose/bin/activate
  (compose)$ pip install docker-compose

Remember to activate the virtualenv to use docker-compose::

  $ source compose/bin/activate
  (compose)$ docker-compose up
  ...

Get the software
++++++++++++++++

The sources for this project are kept in a public repository in github. You
can either clone the repository with git::

  $ git clone https://github.com/Emergya/peer-dockerfiles.git

Or download a compressed copy::

  $ wget https://github.com/Emergya/peer-dockerfiles/archive/v0.1.zip

Configuration
+++++++++++++

Before building the docker images for the production environment, it is
possible to edit the configuration for gunicorn and django. The configuration
for django is in ``peer/config/local_settings.py``. The configuration for
gunicorn is in ``peer/config/gunicorn.py``.

If there is need to modify the configuration after building the images,
it can be done so at ``prod-env/local_settings/``.

Usage
+++++

Note: In case the user running docker commands is not in the docker group,
it may be necessary to use sudo to execute them.

Creating an environment
-----------------------

To create a peer environment, enter in a terminal::

  $ cd /path/to/peer-dockerfiles
  $ vim peer/config/local_settings.py peer/config/gunicorn.py
  $ source /path/to/compose-virtualenv/bin/activate
  $ docker-compose up

This ends up with gunicorn listening on port 8000 of the host machine.

Stopping/Starting the environment
---------------------------------

At any moment, the environment can be stopped and started::

  $ cd /path/to/peer-dockerfiles
  $ docker-compose stop
  $ docker-compose start

This will have no effect on the data we have available in the ``prod-env/``
directory of the host, which will be picked up by the starting container
with no danger of loss.

Upgrading the environment
-------------------------

In case there are new versions of the software that make up the environment,
it can be easily upgraded. The first step is to stop the container, remove it,
and remove the image::

  $ cd /path/to/peer-dockerfiles
  $ docker rm <peer_container>
  $ docker rmi <peer_image>

Then get the peer-dockerfiles tag that describes the upgraded environment::

  $ git checkout <whatever>

Finally, reconstruct the environment. All the data in ``prod-env/`` will be
preserved in the upgraded environment. If there are any data migrations in a
new version of PEER, they will be applied::

  $ docker-compose up

Accessing the data
------------------

All the data managed by the application can be accessed from the host machine,
for inspection and backups. The database can be found at ``prod-env/data``,
and the git repository at ``prod-env/media``.

THE REST OF THIS FILE IS WORK IN PROGRESS, PLEASE IGNORE
++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Reusing previous data
---------------------

If there was a previous peer installation (that was not using docker)
and it is necessary to reuse its
data, we have to edit the Fig config files (i``fig-dev.yml`` or ``fig.yml``).
In the ``volumes`` section of the ``postgresql`` container, we have to change
``dev-env/data:/data`` to ``/path/to/old/pg/datadir:/data`` (assuming we are
using the development environment; if we are using the production environment,
substitute ``dev-env`` with ``prod-env``).

The same applies to git data: We would have to change the volume in the
``peer`` (or ``peerdev``) section from ``dev-env/media:/opt/peer/peer/media``
to ``/path/to/old/peer/media:/opt/peer/peer/media``.

To be able to use the old data in the docker environment, it may be necessary
to change the credentials for PostgreSQL in the django config module at
``peer/config/local_settings.py`` (or ``peer-dev/config/local_settings.py``)
before building the image.

Sources in the development environment
--------------------------------------

It is possible to mount in the peer container the sources for PEER from the
host machine, so that they can be edited in the host and tested in the
container. To do this, it is necessary to add, in the ``volumes`` section of
the ``peerdev`` container definition in ``fig-dev.yml``, a line like::

  - /host/path/to/peer/peer:/opt/peer/peer

Once this is done, the line mapping the media directory in ``volumes``
(``dev-env/media:/opt/peer/peer/media``) should be removed, since the media
directory will already be
in the host machine (at ``/host/path/to/peer/peer/media``).

Be aware that the django settings file at ``/host/path/to/peer/peer`` will
override the one added during `Image configuration for the development
environment`_.
