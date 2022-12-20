#!/usr/bin/env bash
#
# Start the 'SSH server' Docker container.
#
# We will use this Docker container to install SSH server software (OpenSSH), start an SSH server and connect to it
# remotely via an SSH client. Note: because our development environment is already in a container context because we're
# using "Dev Containers", this is a "Docker-in-Docker" scenario. Things can get confusing when doing Docker-in-Docker.

set -eu

docker container run --name ssh-server --rm --interactive --tty --detach mcr.microsoft.com/devcontainers/base:bullseye