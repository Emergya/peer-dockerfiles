#!/bin/bash
# Starts up postgresql within the container.

# Stop on error
set -e

USER="peer"
PASS="peer"
DB="peer"

# Wait for postgres to finish starting up first.
#while [[ ! $( psql -h postgresql -U postgres -lqt | cut -d \| -f 1 | grep -w terms ) ]] ; do
#    inotifywait -q -e create /opt/terms-project/var/run/ >> /dev/null
#done

if [[ -e /firstrun ]]; then
  echo "POSTGRES_USER=$USER"
  echo "POSTGRES_PASS=$PASS"
  echo "POSTGRES_DB=$DB"
  if [ ! -z $DB ];then echo "POSTGRES_DB=$DB";fi

  echo "Creating the superuser: $USER"
  psql -h postgresql -U postgres -q <<-EOF
    DROP ROLE IF EXISTS $USER;
    CREATE ROLE $USER WITH ENCRYPTED PASSWORD '$PASS';
    ALTER USER $USER WITH ENCRYPTED PASSWORD '$PASS';
    ALTER ROLE $USER WITH SUPERUSER;
    ALTER ROLE $USER WITH LOGIN;
EOF

  # create database if requested
  if [ ! -z "$DB" ]; then
    for db in $DB; do
      echo "Creating database: $db"
      psql -h postgresql -U postgres -q <<-EOF
      CREATE DATABASE $db WITH OWNER=$USER ENCODING='UTF8';
      GRANT ALL ON DATABASE $db TO $USER
EOF
    done
  fi
fi
