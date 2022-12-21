# This Dockerfile builds an image that will be used to run an SSH server.

# Let's use an official Debian Docker image to keep things as Linux-native as feasible. Let's pin to a major version
# by its code word instead of using the "latest" tag because it's a moving target. As time goes by, consider the need
# to upgrade to the latest stable release of Debian.
#
# https://hub.docker.com/_/debian
FROM debian:bullseye

RUN apt-get update && \
    apt-get --yes install vim less openssh-server

# Port 22 is the conventional port used for SSH.
EXPOSE 22

# I might go back on this decision, but for now I think it's best to try to use and explore Linux through a non-root
# user.
RUN useradd --create-home myuser
# Note: I can't get a straight answer on this, but we need some kind of "starter password" on this user so we can
# bootstrap the SSH authorized public key and then later change the password.
RUN echo "myuser:myuser" | chpasswd

# Set the default user for running containers
USER myuser