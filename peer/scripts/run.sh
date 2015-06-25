#!/bin/bash

# Stop on error
set -e

if [[ -e /etc/firstrun ]]; then
    echo "Initializing database..."
    django-admin.py migrate --settings=peer.settings --noinput
    echo "Creating admin user..."
    echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'admin')" | \
          django-admin.py shell --settings=peer.settings
    django-admin.py collectstatic --settings=peer.settings --noinput

    echo "Finishing first run..."
    rm -f /etc/firstrun
fi

gunicorn -c /etc/gunicorn.py peer.peer_wsgi:application
