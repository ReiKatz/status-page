#!/bin/bash

set -e

# Start Redis in the background
redis-server &

# Initialize PostgreSQL data directory and start PostgreSQL
#su -c "/usr/lib/postgresql/13/bin/initdb -D /var/lib/postgresql/data" postgres
#su -c "/usr/lib/postgresql/13/bin/postgres -D /var/lib/postgresql/data" postgres

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL

# Create database
CREATE DATABASE statuspage;

# Create user and set password
CREATE USER statuspage WITH PASSWORD 'Aa123456123456';

# Grant privileges to user
GRANT ALL PRIVILEGES ON DATABASE statuspage TO statuspage;

EOSQL
