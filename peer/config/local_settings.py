
# local settings

DEBUG = False

ADMINS = (
  # ('Your Name', 'your_email@example.com'),
)

ALLOWED_HOSTS = ['localhost', 'peer']

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',  # Add 'postgresql_psycopg2', 'postgresql', 'mysql', 'sqlite3' or 'oracle'.
        'NAME': 'peer',                                      # Or path to database file if using sqlite3.
        'USER': 'super',                                      # Not used with sqlite3.
        'PASSWORD': 'peer',                                  # Not used with sqlite3.
        'HOST': 'postgresql',                                # Set to empty string for localhost. Not used with sqlite3.
        'PORT': '5432',                                      # Set to empty string for default. Not used with sqlite3.
    }
}

TIME_ZONE = 'Europe/Madrid'

RECAPTCHA_PUBLIC_KEY = ''
RECAPTCHA_PRIVATE_KEY = ''

SAML_ENABLED = False
SAML_CONFIG = {}
REMOTE_USER_ENABLED = False
