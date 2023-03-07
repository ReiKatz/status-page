# Use an official Python runtime as a parent image
FROM python:3.10

# Set the working directory to /status-page
WORKDIR /status-page

# Install dependencies
RUN apt-get update && \
    apt-get install -y libxml2-dev libxslt1-dev libffi-dev libpq-dev libssl-dev zlib1g-dev
    
# Install sql and redis
RUN apt-get update && apt-get install -y postgresql-client
RUN apt-get install -y redis-tools
# Install any needed packages specified in requirements.txt
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY statuspage/manage.py ./statuspage/
COPY statuspage/statuspage/settings.py ./statuspage/
COPY . .

# run the upgrade script
RUN bash ./upgrade.sh && \
    python3 -m venv /venv && \
    python3 -c 'import os; from django.core.wsgi import get_wsgi_application; os.environ.setdefault("DJANGO_SETTINGS_MODULE", "statuspage.settings"); get_wsgi_application().apps.populate(settings.INSTALLED_APPS); from django.contrib.auth.models import User; User.objects.create_superuser("user3", email="superuser@email.com", password="password")'

EXPOSE 8000 5432 6379

# Start the Django application
CMD ["python3", "./statuspage/manage.py", "runserver", "0.0.0.0:8000", "--insecure"]
