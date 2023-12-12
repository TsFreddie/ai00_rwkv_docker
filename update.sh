#!/bin/bash

# Target repository URL
docker_hub_url="https://hub.docker.com/r/tsfreddie/ai00_rwkv_docker"

# GitHub repository release api URL
api_url="https://api.github.com/repos/cgisky1980/ai00_rwkv_server/releases/latest"

# Get the latest release version from the GitHub API
latest_release=$(curl -sSL "$api_url" | grep -oP '"tag_name": "\K(.*?)(?=")')

# Check if the latest release version is empty
if [[ -z "$latest_release" ]]; then
  echo "No new release found."
  exit 1
fi

# Check whether the docker hub version already exists using the docker hub API
docker_hub_api_url="$docker_hub_url/tags/$latest_release"
docker_hub_api_response=$(curl -sSL -o /dev/null -w "%{http_code}" "$docker_hub_api_url")

# Check if the docker hub API response is 200
if [[ "$docker_hub_api_response" -eq 200 ]]; then
  echo "Docker hub version already exists."
  exit 1
fi

# Construct the release file URL
release_file_url="$repo_url/releases/download/$latest_release/ai00_server-$latest_release-x86_64-unknown-linux-gnu.zip"

# Download the release file
wget "$release_file_url"

# Unzip the file
unzip "ai00_server-$latest_release-x86_64-unknown-linux-gnu.zip"

# Rename dist/assets to dist/assets_source
mv dist/assets dist/assets_source

# Save latest_release to global env
echo "latest_release=$latest_release" >> $GITHUB_ENV

