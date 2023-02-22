# Use an official Python runtime as a parent image
FROM python:3.10-alpine3.16

# Set the working directory to /status-page
WORKDIR /status-page

# define the configuration file as a default argument to the build command
ARG CONFIG_FILE=statuspage/statuspage/configuration.py
COPY $CONFIG_FILE .

RUN apk add --no-cache postgresql-dev
RUN apk add --no-cache build-base

RUN apk update && apk add sudo

RUN adduser -S myuser && echo "myuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER myuser

# Install extras package
RUN pip install extras

# Install any needed packages specified in requirements.txt
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the statuspage folder and the manage.py file
COPY statuspage/ statuspage/
COPY statuspage/manage.py .

# run the upgrade script
COPY upgrade.sh .
RUN sudo chmod +x upgrade.sh 
RUN sudo sh ./upgrade.sh

# activate virtual environment
RUN source venv/bin/activate

# create the superuser
RUN python manage.py createsuperuser

# Expose port 8000 for the Django application
EXPOSE 8000

# Start the Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
