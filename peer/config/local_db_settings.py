
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',  # Add 'postgresql_psycopg2', 'postgresql', 'mysql', 'sqlite3' or 'oracle'.
        'NAME': 'peer',                                      # Or path to database file if using sqlite3.
        'USER': 'peer',                                      # Not used with sqlite3.
        'PASSWORD': 'peer',                                  # Not used with sqlite3.
        'HOST': 'postgresql',                                          # Set to empty string for localhost. Not used with sqlite3.
        'PORT': '5432',                                          # Set to empty string for default. Not used with sqlite3.
    }
}

# DATABASES = {
    # 'default': {
        # 'ENGINE': 'django.db.backends.sqlite3',      # Add 'postgresql_psycopg2', 'postgresql', 'mysql', 'sqlite3' or 'oracle'.
        # 'NAME': '/data/peer.db',                     # Or path to database file if using sqlite3.
    # }
# }
