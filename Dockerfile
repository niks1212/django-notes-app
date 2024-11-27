# Use the official Python image
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app/backend

# Copy the requirements file first to leverage Docker caching
COPY requirements.txt /app/backend/

# Update system packages and install necessary system dependencies
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . /app/backend/

# Expose the port Django will run on
EXPOSE 8000

# Default command to run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
