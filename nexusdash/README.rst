=========
NexusDash
=========

Program
=======
Nexus Dash

- A Django based monitoring web dashboard for Nexus machines. Simply drop-in the app and go!

Features
========

- A beautiful web-based dashboard for monitoring Nexus info

- Interactive graphs showing historical data of Nexus

- Live, on-demand monitoring of RAM, CPU, Load, Uptime, Disk Allocation, Interface Throughput and many more system stats

- Make your own Django App Plugin and easily add to this website
  
- Cross platform application (Windows and Unix supported)

- Uses Celery to allow asynchronously polling devices


Installation (Unix)
===================

1) Install Dependencies using Conda
-----------------------------------

Follow these CLI commands to install all dependencies::

    $ # No need to sudo
    $ cd /tmp/
    $ # Install Miniconda
    $ wget http://repo.continuum.io/miniconda/Miniconda-3.5.5-Linux-x86_64.sh
    $ chmod +x Miniconda-3.5.5-Linux-x86_64.sh
    $ ./Miniconda-3.5.5-Linux-x86_64.sh
    $ 기본적으로 $HOME/miniconda 에 설치됩니다. 
    $ 향후 설치에 필요한 패키지 추가 
    $ sudo apt-get install libxml2-dev libxslt1-dev python-dev python-lxml libmysqlclient-dev
    $ 여러개의 nexus switch 추가시 database locked 오류에 대해서 mysql로 backend 변경시 libmysqlclient-dev 패키지 필요 
    
    $ export PATH=$HOME/miniconda/bin:$PATH 로 conda 실행파일에 경로를 추가해주세요! 
    $
    $ # Create a Python env
    $ conda create --name nexusdash pip 
    $ source activate nexusdash
    $ conda install pip
    $ 
    $ # Download ./requirements.txt from source
    $ ## Use following args for pip if server doesn't allow SSL: --index-url http://pypi.gocept.com/simple/ --allow-all-external --timeout 60
    $ pip install -r requirements.txt

NOTE: Get the latest nexusdash from here: https://bitbucket.org/abarik1981/nexusdash

   간단한 실행 방법 
   $ startup.sh 이후 서버의 ${local_ip}:5550 으로 접속! 
   $ 종료시 shutdown.sh 

2) Start the Django Server
--------------------------

Follow these CLI commands to run the Django Server::

    $ source activate nexusdash
    $ # Key can be any string
    $ export SECRET_KEY=asdaduy7683ybhby
    $ 
    $ # Set Django Setting, to run in production env, use nexusdash.settings.production
    $ export DJANGO_SETTINGS_MODULE=nexusdash.settings.local
    $ 
    $ # Sync Database and create root admin account
    $ python manage.py syncdb
    $ python manage.py migrate 
    $
    $ # To run in Development env
    $ python manage.py runserver 0.0.0.0:5550
    $ 
    $ # To run in Production env
    $ python manage.py runserver 0.0.0.0:5550 --noreload
    


3) Start Celery for polling
---------------------------

Follow these CLI commands to start Celery::

    $ source activate nexusdash
    $ # Key can be any string
    $ export SECRET_KEY=asdaduy7683ybhby
    $ 
    $ # Set Django Setting, to run in production env, use nexusdash.settings.production
    $ export DJANGO_SETTINGS_MODULE=nexusdash.settings.local
    $ 
    $ cd \path\to\nexusdash-with-manage.py
    $ 
    $ # Start Periodic polling
    $ celery -A nexusdash beat
    $ 
    $ # Start celery
    $ celery -A nexusdash worker -l info
    
    
4) Navigate to website
----------------------

Enjoy!!


Settings
========

1) Polling Interval
-------------------

- To change the interval at which the devices get polled periodically, change the variable CELERYBEAT_SCHEDULE in ./nexusdash/settings/base.py

- Default value is every 30 minutes (e.i: '*/30')
