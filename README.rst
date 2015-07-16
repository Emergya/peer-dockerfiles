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
possible to edit the configuration for the django db settings, at
``peer/config/local_db_settings.py``.

If there is need to modify the configuration after building the images,
for both django and gunicorn, it can be done so at
``prod-env/local_settings/gunicorn.py`` and
``prod-env/local_settings/local_settings.py``.

Usage
+++++

Note: In case the user running docker commands is not in the docker group,
it may be necessary to use sudo to execute them.

Creating an environment
-----------------------

To create a peer environment, enter in a terminal::

  $ cd /path/to/peer-dockerfiles
  $ vim peer/config/local_db_settings.py
  $ source /path/to/docker-compose-virtualenv/bin/activate
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

  $ git pull
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

Development environment
+++++++++++++++++++++++

In the development environment we use django's development server
to serve PEER checked out from github in an environment built by buildout.

Configuration
-------------

The buildout config in ``peer-dev/config/buildout.cfg`` can be edited before
building the image to change the environment to be built by buildout.

Also, in the ``development.yml`` config file for docker-compose, there is a
volume commented out, it can be uncommented and adjusted to the local path
to the PEER sources in the docker host machine, so that they can be edited
outside the container and the effects of the edition can be seen in the
container.

The django settings files in the PEER sources in the host machine must be
adjusted before building the docker images (an example config file is provided
as local_settings.example in the peer sources). In particular, the database
configuration will govern the creation of the db, so it is important to get
it right. In this version, the driver must be sqlite3, and the NAME of the
db should be ``/data/peer.db``.

Data and logs
-------------

The PEER database should be exposed in the host machine at ``dev-env/data/``.
The logs from django should be exposed at ``dev-env/logs/``.
The git data, that lives in django's ``media/`` directory, should be accesible
at the local path to the project sources in the host machine, if they have been
mounted in the container at ``/opt/peer/peer/``.

Using the environment
---------------------

The environment is managed in the same way as the production environment,
except that we must specify the docker-compose config file::

  $ docker-compose -f development.yml up
