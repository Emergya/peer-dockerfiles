#!/bin/bash
# Starts up postgresql within the container.

# Stop on error
set -e
DATA_DIR=/data

if [[ -e /firstrun ]]; then
  # Echo out info to later obtain by running `docker logs container_name`
  echo "POSTGRES_DATA_DIR=$DATA_DIR"

  # test if DATA_DIR has content
  if [[ ! "$(ls -A $DATA_DIR)" ]]; then
      echo "Initializing PostgreSQL at $DATA_DIR"

      # Copy the data that we generated within the container to the empty DATA_DIR.
      cp -R /var/lib/postgresql/9.4/main/* $DATA_DIR
  fi

  # Ensure postgres owns the DATA_DIR
  chown -R postgres $DATA_DIR
  # Ensure we have the right permissions set on the DATA_DIR
  chmod -R 700 $DATA_DIR

  rm /firstrun
fi

# Start PostgreSQL
echo "Starting PostgreSQL..."
setuser postgres /usr/lib/postgresql/9.4/bin/postgres -D /etc/postgresql/9.4/main
