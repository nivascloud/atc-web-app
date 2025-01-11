# Use Python 3.8 slim image as base
FROM python:3.8-slim

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl && \
    pip install flask prometheus_client

# Set the working directory in the container
WORKDIR /app

# Copy the application code and templates
COPY app.py /app/
COPY templates /app/templates

# Expose ports for the web server (8080) and Prometheus metrics (8000)
EXPOSE 8080 8000

# Command to run the application
CMD ["python", "app.py"]