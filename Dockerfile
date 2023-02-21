# Use an official Python runtime as a parent image
FROM python:3.10-alpine3.16

# Set the working directory to /status-page
WORKDIR /status-page

# Install any needed packages specified in requirements.txt
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 8000 for the Django application
EXPOSE 8000

# Start the Django application
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
