#!/bin/bash

# Stop on error
set -e

export PGPASSWORD="peer"

until psql -h "postgresql" -U "peer" -c '\l'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

cd /opt/peer

if [[ -e /etc/firstrun ]]; then

    echo "Setting up configuration..."
    touch /opt/peer/peer/local_settings/__init__.py
    mv -f /config/settings.pre-image /opt/peer/peer/settings.py
    mv -f /config/local_db_settings.py /opt/peer/peer/local_settings/local_db_settings.py
    
    if [[ ! -e /opt/peer/peer/local_settings/local_settings.py ]]; then
        mv -f /config/local_settings.pre-image /opt/peer/peer/local_settings/local_settings.py
    fi
    
    if [[ ! -e /opt/peer/peer/local_settings/gunicorn.py ]]; then
        mv -f /config/gunicorn.pre-image /opt/peer/peer/local_settings/gunicorn.py
    fi

    new=1
    if psql -h "postgresql" -U "peer" -lqt | cut -d \| -f 1 | grep -qw peer; then
        echo "PEER tables already created..."
        new=0
    fi

    echo "Initializing / migrating database..."
    /opt/peer/bin/django migrate --settings=peer.settings --noinput

    #if (( $new == 1 )); then
        echo "Creating admin user..."
        echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'admin')" | \
            /opt/peer/bin/django shell --settings=peer.settings
    #fi

    echo "Collecting static files..."
    /opt/peer/bin/django collectstatic --settings=peer.settings --noinput

    echo "Finishing first run..."
    rm -f /etc/firstrun
fi

exec start-stop-daemon --start --exec \
      /opt/peer/bin/gunicorn -- -c /opt/peer/peer/local_settings/gunicorn.py peer.peer_wsgi:application
