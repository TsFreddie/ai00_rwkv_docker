#!/bin/sh

# Check if the '/app/assets' directory exists, if not create it
if [ ! -d "/app/assets" ]; then
  mkdir /app/assets
fi

# Check if the 'assets' directory is empty
if [ -z "$(ls -A /app/assets)" ]; then
  # If it's empty, copy the contents of 'assets_source' into 'assets'
  cp -r /app/assets_source/. /app/assets/
fi

# cd into working directory
cd /app

# Run the server
./ai00_server
