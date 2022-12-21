# This Dockerfile builds an image that will be used to run an SSH server.

# Let's use an official Debian Docker image to keep things as Linux-native as feasible. Let's pin to a major version
# by its code word instead of using the "latest" tag because it's a moving target. As time goes by, consider the need
# to upgrade to the latest stable release of Debian.
#
# https://hub.docker.com/_/debian
FROM debian:bullseye

RUN apt-get update && \
    apt-get --yes install vim openssh-server