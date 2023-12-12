# Use an official Alpine image as the base
FROM debian:bookworm-slim

# Set the working directory in the container to /app
WORKDIR /app

# Copy the 'dist' directory from your host to the present location (.) in your image
COPY ./dist .

# Copy the 'run.sh' file
COPY ./run.sh .

# Install dependencies
RUN apt-get update && apt-get install -y vulkan-tools vulkan-validationlayers libvulkan1 libvulkan-dev mesa-vulkan-drivers && rm -rf /var/lib/apt/lists/*

# Make sure run.sh and ai00_server have execute permissions
RUN chmod +x run.sh
RUN chmod +x ai00_server

# Expose port 65530
EXPOSE 65530

# Mount assets directory
VOLUME ["/app/assets"]

# Call run.sh when the container launches
CMD ["/app/run.sh"]
