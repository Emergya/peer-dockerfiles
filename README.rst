PEER Dockerfiles
################

Docker environment for PEER.

Dependencies
++++++++++++

Docker
------

`Docker <https://www.docker.com/>`_ is needed to run this sowftware.
On ubuntu, just run::

  $ sudo apt-get install docker.io

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
possible to edit some configuration files, at ``peer/config/`` and
``nginx/etc``.

Usage
+++++

Note: In case the user running docker commands is not in the docker group,
it may be necessary to use sudo to execute them.

Creating an environment
-----------------------

To create a peer environment, enter in a terminal::

  $ cd /path/to/peer-dockerfiles
  $ vim peer/config/local_db_settings.py
  $ docker-compose up

This ends up with 3 containers, one running postgresql, one running the peer
app under gunicorn, and one running nginx.

Stopping/Starting the environment
---------------------------------

At any moment, the environment can be stopped and started::

  $ cd /path/to/peer-dockerfiles
  $ docker-compose stop
  $ docker-compose start

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

Finally, reconstruct the environment. All the data in ``data/`` will be
preserved in the upgraded environment. If there are any data migrations in a
new version of PEER, they will be applied::

  $ docker-compose up

Accessing the data
------------------

All the data managed by the application can be accessed from the host machine,
for inspection and backups. The database can be found at ``data/``,
and the git repository at ``media/``.

