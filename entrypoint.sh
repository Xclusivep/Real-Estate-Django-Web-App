#!/bin/sh

# Run database migrations
python manage.py migrate --noinput

# Start the Django development server
python manage.py runserver 0.0.0.0:8000

