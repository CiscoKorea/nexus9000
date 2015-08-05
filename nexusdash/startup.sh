#!/bin/bash 

source ~/miniconda/bin/activate nexusdash

sleep 2

export SECRET_KEY=asdaduy7683ybhby
export DJANGO_SETTINGS_MODULE=nexusdash.settings.local

python manage.py syncdb
python manage.py migrate 

python manage.py runserver 0.0.0.0:5550  & 

sleep 5

celery -A nexusdash beat & 

sleep 5
celery -A nexusdash worker -l info & 
