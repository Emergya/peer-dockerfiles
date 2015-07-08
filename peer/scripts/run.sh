#!/bin/bash

# Stop on error
set -e

if [[ -e /etc/firstrun ]]; then

    echo "Setting up configuration..."
    touch /usr/local/lib/python2.7/dist-packages/peer/local_settings/__init__.py
    mv -f /config/settings.py /usr/local/lib/python2.7/dist-packages/peer/settings.py
    mv -f /config/local_settings.py /usr/local/lib/python2.7/dist-packages/peer/local_settings/local_settings.py
    mv -f /config/gunicorn.py /usr/local/lib/python2.7/dist-packages/peer/local_settings/gunicorn.py

    new=1
    if [[ -e /data/peer.db ]]; then
        new=0
    fi

    echo "Initializing / migrating database..."
    django-admin.py migrate --settings=peer.settings --noinput

    if (( $new == 1 )); then
        echo "Creating admin user..."
        echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'admin')" | \
            django-admin.py shell --settings=peer.settings
    fi

    echo "Collecting static files..."
    django-admin.py collectstatic --settings=peer.settings --noinput

    echo "Finishing first run..."
    rm -f /etc/firstrun
fi

gunicorn -c /usr/local/lib/python2.7/dist-packages/peer/local_settings/gunicorn.py peer.peer_wsgi:application
