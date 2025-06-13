#!/bin/bash

service ssh start

exec gunicorn --bind 0.0.0.0:${PORT:-8000} --timeout 600 --access-logfile - --error-logfile - app:app