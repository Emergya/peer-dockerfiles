#!/bin/bash

# Stop on error
set -e

if [[ -e /firstrun ]]; then

  if [[ -e /scripts/initdb.sh ]]; then
    bash /scripts/initdb.sh
  fi

  echo "Creating DB schema..."
  django-admin.py syncdb --settings=peer.settings --noinput
  echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'admin')" | \
        django-admin.py shell --settings=peer.settings
  echo "Migrating DB schema..."
  django-admin.py migrate --settings=peer.settings

  django-admin.py collectstatic --settings=peer.settings --noinput --link

  a2enmod wsgi
  a2dissite 000-default
  a2ensite peer

  mkdir -p /var/log/apache2

  echo "Finishing first run..."
  rm /firstrun
fi

echo "Starting apache2 server..."
source /etc/apache2/envvars
exec apache2 -DNO_DETACH -DFOREGROUND
