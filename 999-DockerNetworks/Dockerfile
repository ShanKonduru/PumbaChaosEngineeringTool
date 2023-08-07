# Use the official Node.js image as the base image
FROM node

# Install sudo and jq
RUN apt-get update && apt-get install -y sudo jq

# Set up a non-root user (optional but recommended)
RUN useradd -m myuser && echo "myuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set the default user for the container
USER myuser

# Any additional setup or configuration specific to your application goes here
