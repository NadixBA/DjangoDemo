import sys
import os

from django.conf import settings                # settings.py

SECRET_KEY = 'StrengGeheim'

ALLOWED_HOSTS = os.environ.get('ALLOWED_HOSTS', '127.0.0.1').split(',') # split: for multiple ALLOWED_HOSTS
# '127.0.0.1' should be 'localhost'
# only the localhost can request -> later: www.homepage.de
settings.configure(
    DEBUG=True,
    SECRET_KEY=SECRET_KEY,
    ALLOWED_HOSTS=ALLOWED_HOSTS,
    ROOT_URLCONF=__name__,
    MIDDLEWARE_CLASSES=(
        'django.middleware.common.CommonMiddleware',
        'django.middleware.csrf.CsrfViewMiddleware',
        'django.middleware.clickjacking.XFrameOptionsMiddleware',
        ),
)

from django.conf.urls import url                # same as urls.py
from django.http import HttpResponse

def index(request):
    return HttpResponse('Hello World xD... sooo Robin,\n'
                        'was du hier siehst ist unsere erste Serverabfrage: '
                        '[Datum Uhrzeit] "GET / HTTP/1.1" 200 11 '
                        'Der Rest in fine tuning.')

urlpatterns = (
        url(r'^$', index),
    )

from django.core.wsgi import get_wsgi_application   # same as msgi.py
                                                    # Web Server gateway interface
application = get_wsgi_application()

if __name__ == "__main__":                          # same as manage.py
    from django.core.management import execute_from_command_line

    execute_from_command_line(sys.argv)

# start:                python django_helloWorld.py runserver    in Terminal
# create new Project:   django-admin startproject mysite
