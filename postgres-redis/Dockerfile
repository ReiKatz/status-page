# Base image for Redis and PostgreSQL
FROM debian:bullseye-slim

# Install Redis and PostgreSQL
RUN apt-get update && \
    apt-get install -y redis postgresql && \
    apt-get clean

# Create a data directory for PostgreSQL
RUN mkdir -p /var/lib/postgresql/data && \
    chown -R postgres:postgres /var/lib/postgresql/data

# Expose ports for Redis and PostgreSQL
EXPOSE 6379 5432

ENV POSTGRES_USER=statuspage
ENV POSTGRES_PASSWORD=Aa123456123456
ENV POSTGRES_DB=status-page

# Set up the entrypoint script to start Redis and PostgreSQL
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
