#!/bin/bash

# Stop on error
set -e

cd /opt/peer

if [[ -e firstrun ]]; then

    new=1
    if [[ -e /data/peer.db ]]; then
        new=0
    fi

    echo "Initializing / migrating database..."
    bin/django migrate --settings=peer.settings --noinput

    if (( $new == 1 )); then
        echo "Creating admin user..."
        echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'admin')" | \
            bin/django shell --settings=peer.settings
    fi

    echo "Finishing first run..."
    rm -f firstrun

fi

cd /opt/peer
bin/django runserver 0.0.0.0:8080
