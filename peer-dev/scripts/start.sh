#!/bin/bash

# Stop on error
set -e

if [[ -e /firstrun ]]; then

  if [[ -e /scripts/initdb.sh ]]; then
    bash /scripts/initdb.sh
  fi

  /opt/peer/bin/django syncdb --settings=peer.settings --noinput
  echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'admin')" | \
        /opt/peer/bin/django shell --settings=peer.settings
  /opt/peer/bin/django migrate --settings=peer.settings

  /opt/peer/bin/django collectstatic --settings=peer.settings --noinput --link

  echo "Finishing first run..."
  rm -f /firstrun
fi

cd /opt/peer
bin/django runserver 0.0.0.0:8080
