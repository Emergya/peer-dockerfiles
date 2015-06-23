#!/bin/bash


if [[ -e /etc/firstrun ]]; then
    echo "Initializing database..."
    django-admin.py syncdb --settings=peer.settings --noinput --all
    django-admin.py migrate --settings=peer.settings --noinput --fake
    echo "Creating admin user..."
    echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'admin')" | \
          django-admin.py shell --settings=peer.settings
    django-admin.py collectstatic --settings=peer.settings --noinput

    echo "Finishing first run..."
    rm -f /etc/firstrun
fi

gunicorn -c /etc/gunicorn.py peer.peer_wsgi:application
