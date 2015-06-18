#!/bin/bash

# Stop on error
set -e

echo "Creating DB schema..."
django-admin.py syncdb --settings=peer.settings --noinput
echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'admin')" | \
      django-admin.py shell --settings=peer.settings
echo "Migrating DB schema..."
django-admin.py migrate --settings=peer.settings
echo "Collecting static files..."
django-admin.py collectstatic --settings=peer.settings --noinput --link
