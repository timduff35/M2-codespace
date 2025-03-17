# Use Ubuntu as base image
FROM ubuntu:latest

# Set non-interactive mode to avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies
RUN apt-get update && apt-get install -y software-properties-common

# Add the Macaulay2 PPA and install Macaulay2
RUN add-apt-repository -y ppa:macaulay2/macaulay2 && \
    apt-get update && \
    apt-get install -y macaulay2

# Set default shell
SHELL ["/bin/bash", "-c"]

# Verify installation
RUN M2 --version

# Set the default user (vscode is the default user for Codespaces)
USER vscode
