#!/bin/bash

#TODO: prompt the user for this
PROJECT_NAME='mytestproject'
APP_NAME='testapp'

#TODO: check to see if virtualenv exists
virtualenv --no-site-packages $PROJECT_NAME

cd $PROJECT_NAME
source bin/activate
pip install django
pip install nodeenv
nodeenv -p
npm install less

#TODO: make sure there are no hyphens in PROJECT_NAME or APP_NAME
django-admin.py startproject --template=https://github.com/charlon/django-adaptive-proj-template/archive/master.zip --extension=py,in,html $PROJECT_NAME
cd $PROJECT_NAME
django-admin.py startapp --template=https://github.com/charlon/django-adaptive-app-template/archive/master.zip --extension=py,in,html $APP_NAME

pip install -r requirements.txt

# add app to INSTALLED_APPS and project urls.py
#TODO: set a SECRET_KEY that is unique
cd $PROJECT_NAME
sed -i.bak "s/# 'app_name'/'$APP_NAME'/g" settings.py
rm settings.py.bak
sed -i.bak "s/#url(r'^', include('app_name.urls'))/url(r'^', include('$APP_NAME.urls'))/g" urls.py
rm urls.py.bak
