#!/usr/bin/env bash
#
# Attach to the 'SSH server' Docker container.

# Because we're layers deep in logical host processes (VS Code + Docker + Integrated terminal (and shell) + Docker-in-Docker
# shell), we're not able to send the 'Ctrl + p, Ctrl + q' control sequence to detach from the 'SSH server' Docker container.
# When I press those keys I think it gets intercepted by VS Code because it has no effect. By contrast, when I run a
# Docker container from iTerm, that sequence does detach from the container.
#
# The behavior and techniques relating to running detached interactive Docker containers, attaching to them, and detaching
# from them is well-discussed in discussions like this StackOverflow question and answers: https://stackoverflow.com/q/25267372
#
# Our workaround is to define a special detach sequence. Arbitrarily, let's decide that typing 'xit@@@'' will detach us
# from the container. See https://docs.docker.com/engine/reference/commandline/attach/#override-the-detach-sequence
#
# Starting with an 'x' instead of the letter 'e' which is the proper spelling of the word 'exit' is useful because 'x'
# is a much less frequently used letter so you won't run into the "key presses are invisible" issue as frequently.
#
# Admittedly, this is an unusual scenario but the ability to attach/detach from a container is important for enabling a
# convenient and exploratory development environment which is critical for "playground"-style repositories like 'linux-playground'.
# The workaround is worth it. Be sure to document your quirky workarounds!
docker attach --detach-keys='x,i,t,@,@,@' ssh-server