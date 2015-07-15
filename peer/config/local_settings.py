import sys
# local settings

DEBUG = False
TEMPLATE_DEBUG = DEBUG

ADMINS = (
  # ('Your Name', 'your_email@example.com'),
)

ALLOWED_HOSTS = ['localhost', 'peer']

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',      # Add 'postgresql_psycopg2', 'postgresql', 'mysql', 'sqlite3' or 'oracle'.
        'NAME': '/data/peer.db',                     # Or path to database file if using sqlite3.
    }
}

TIME_ZONE = 'Europe/Madrid'

EMAIL_HOST = 'smtp.example.com'
EMAIL_PORT = 25

DEFAULT_FROM_EMAIL = 'no-reply@example.com'

EMAIL_HOST_USER = None
EMAIL_HOST_PASSWORD = None

EMAIL_USE_TLS = False
EMAIL_USE_SSL = False

RECAPTCHA_PUBLIC_KEY = ''
RECAPTCHA_PRIVATE_KEY = ''

SAML_ENABLED = False
SAML_CONFIG = {}
REMOTE_USER_ENABLED = False

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'verbose': {
            'format': '%(levelname)s %(asctime)s %(module)s %(process)d %(thread)d %(message)s'
        },
        'generic': {
            'format': '%(asctime)s [%(process)d] [%(levelname)s] %(message)s',
            'datefmt': '%Y-%m-%d %H:%M:%S',
            'class': 'logging.Formatter',
        },
    },
    'handlers': {
        'console':{
            'level':'INFO',
            'class':'logging.StreamHandler',
            'stream': sys.stdout,
            'formatter': 'verbose',
        },
    },
    'loggers': {
        'django': {
            'handlers': ['console'],
            'propagate': True,
            'level': 'DEBUG',
        },
        'rest': {
            'handlers': ['console'],
            'level': 'DEBUG',
        },
    }
}
