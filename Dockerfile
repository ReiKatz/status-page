# Use an official Python runtime as a parent image
FROM python:3.10

# Set the working directory to /status-page
WORKDIR /status-page

# Install any needed packages specified in requirements.txt
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY statuspage/manage.py ./statuspage/
COPY statuspage/statuspage/settings.py ./statuspage/
COPY . .

RUN 

# run the upgrade script
RUN bash ./upgrade.sh && \
    python3 -m venv /venv && \
    python3 ./statuspage/manage.py createsuperuser --no-input --email superuser@email.com --user user2

EXPOSE 8000

# Start the Django application
CMD ["python3", "./statuspage/manage.py", "runserver", "0.0.0.0:8000", "--insecure"]
