#!/usr/bin/env bash
#
# Start the 'SSH server' Docker container.
#
# We will use this Docker container to install SSH server software (OpenSSH), start an SSH server and connect to it
# remotely via an SSH client from the main dev container. Note: because our development environment is already in a
# container context because we're using "Dev Containers", this is a "Docker-in-Docker" scenario. Things can get confusing
# when doing Docker-in-Docker.

# Let's use an official Debian Docker image to keep things as Linux-native as feasible. Let's pin to a major version
# by its code word instead of using the "latest" tag because it's a moving target. As time goes by, consider the need
# to upgrade to the latest stable release of Debian.
#
# https://hub.docker.com/_/debian
IMAGE=debian:bullseye

set -eu

docker container run \
    --name ssh-server \
    --rm \
    --interactive \
    --tty \
    --detach \
    "$IMAGE"