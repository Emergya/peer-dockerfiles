# Postgresql (http://www.postgresql.org/)
# originally from https://github.com/Painted-Fox/docker-postgresql/blob/master/Dockerfile

FROM phusion/baseimage:0.9.16

MAINTAINER Enrique Perez Arnaud <eperez@emergya.com>

# Ensure we create the cluster with UTF-8 locale
RUN locale-gen en_US.UTF-8 && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale

# Install the latest postgresql
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --force-yes \
        postgresql-9.4 postgresql-client-9.4 postgresql-contrib-9.4 && \
    service postgresql stop && \
    update-rc.d postgresql disable

# Install other tools.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y pwgen inotify-tools

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 5432
ADD etc/postgresql.conf /etc/postgresql/9.4/main/postgresql.conf
ADD etc/pg_hba.conf /etc/postgresql/9.4/main/pg_hba.conf
ADD scripts /scripts
RUN chmod +x /scripts/start.sh
RUN touch /firstrun
RUN mkdir /data
RUN chown postgres /data

# Add daemon to be run by runit.
RUN mkdir /etc/service/postgresql
RUN ln -s /scripts/start.sh /etc/service/postgresql/run

# Expose our data, log, and configuration directories.
#VOLUME ["/data", "/var/log/postgresql", "/etc/postgresql"]

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
