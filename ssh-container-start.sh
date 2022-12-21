#!/usr/bin/env bash
#
# Build the 'SSH server' image and start it as a container.
#
# We will use this Docker container to install SSH server software (OpenSSH), start an SSH server and connect to it
# remotely via an SSH client from the main dev container. Note: because our development environment is already in a
# container context because we're using "Dev Containers", this is a "Docker-in-Docker" scenario. Things can get confusing
# when doing Docker-in-Docker.

set -eu

IMAGE=linux-playground-ssh

docker build --tag $IMAGE --file linux-playground-ssh.Dockerfile .

docker container run \
    --name ssh-server \
    --rm \
    --interactive \
    --tty \
    --detach \
    --publish 2345:22 \
    $IMAGE