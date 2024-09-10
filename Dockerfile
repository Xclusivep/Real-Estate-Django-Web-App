# Step 1: Use an official Python runtime as a parent image
FROM python:3.8-slim

# Step 2: Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Step 3: Set the working directory in the container
WORKDIR /app

# Step 4: Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev gcc \
    && apt-get clean

# Step 5: Copy the requirements file into the container
COPY requirements.txt /app/

# Step 6: Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Step 7: Copy the current directory contents into the container
COPY . /app

# Step 8: Set up PostgreSQL environment variables (replace with actual values in production)
ENV POSTGRES_DB=admin
ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=admin
ENV POSTGRES_HOST=postgres-db
ENV POSTGRES_PORT=5432

# Step 9: Collect static files (this will use Whitenoise to serve static files)
RUN python manage.py collectstatic --noinput

# Step 10: Expose port 8000 to the outside world
EXPOSE 8000

# Step 11: Copy the entrypoint script
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Step 12: Define the entrypoint script to run migrations and start the server
ENTRYPOINT ["/entrypoint.sh"]
