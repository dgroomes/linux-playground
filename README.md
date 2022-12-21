# linux-playground

NOT YET FULLY IMPLEMENTED

📚 Learning and exploring Linux.

---
**NOTE**:

This was developed on macOS and for my own personal use.

---


## Overview

This repository is for me to explore Linux. That's a wide scope of technology! Because I develop on macOS, I need a test
bed for exploring Linux. I'll do this by exploring Linux in a Docker container by way of [remote development in VS Code
using a "Dev Container"](https://code.visualstudio.com/docs/remote/remote-overview).

I'll choose the [Debian](https://www.debian.org/) Linux distribution to experiment with for two reasons. First, it's a
common distribution to build containerized workloads like web servers on top of, and I've used it for many of my own
workloads. Secondly, Debian is in the middle of the spectrum between small distributions like [Arch](https://archlinux.org/)
and large distributions that can be used on the desktop like [Ubuntu](https://ubuntu.com/). It seems like an effective
representative.

There are some miscellaneous things I'd like to learn about Linux (or even more broadly Unix-based systems and computing
tools) like SSH (again, not a Linux-specific thing), systemd, file permissions, Unix domain sockets, and more.


## Instructions

Follow these instructions to follow along with the learning journey presented by this codebase.

1. Start Docker
   * You should have Docker Desktop (or an alternative, like [Colima](https://github.com/abiosoft/colima)) installed and
     running.
1. Open this project in VS Code
1. Attach VS Code to the dev container
   * VS Code will prompt you with a notification to reopen the project in a dev container. Click the "Reopen in Container"
     button.
1. Show the Debian version
   * Issue the following command in the VS Code integrated terminal.
   * ```shell
     lsb_release -a
     ```
   * Altogether, it should look like this.
   * ```text
     vscode ➜ /workspaces/linux-playground $ lsb_release -a
     No LSB modules are available.
     Distributor ID: Debian
     Description:    Debian GNU/Linux 11 (bullseye)
     Release:        11
     Codename:       bullseye
     ```
   * Or, look at the version in the `/etc/debian_version` file. It should look like this.
   * ```text
     vscode ➜ /workspaces/linux-playground $ cat /etc/debian_version 
     11.6
     ```
1. Start a Docker container
   * ```shell
     ./ssh-container-start.sh
     ```
   * This is a "Docker-in-Docker" scenario. We are going to use this container to explore SSH.
1. Check the status of the container
   * ```shell
     docker container ls
     ```   
   * This is a command you will use frequently to see what containers are up, what ports are forwarded, what are the IDs
     of the containers, etc. You might know about the older command that does the same thing: `docker ps`.
1. Attach to the container
   * ```shell
     ./ssh-container-attach.sh
     ```
   * Start experimenting. When you want to detach from this container and return to the dev container, you need to type
     a special string of characters. Read the detailed note in `ssh-container-attach.sh`. Now, you have a substantial
     two-system Linux development and exploration environment that you can freely explore!
1. Restart the SSH service in the container
   * For some reason, the SSH service needs to be restarted. If I don't restart it then I have trouble ssh'ing into the
     container and I get a `kex_exchange_identification: read: Connection reset by peer` error. Use the following
     command to start an interactive Bash session in the container.
   * ```shell
     docker exec --user root --tty --interactive ssh-server bash
     ```
   * Then, while you're in the container, restart the SSH server with the following command and exit.
   * ```shell
     service ssh restart && exit
     ```
1. SSH into the container
   * ```shell
     ssh -o StrictHostKeyChecking=accept-new -p 2345 myuser@localhost
     ```
   * It will prompt you for a password. Refer to the `Dockerfile` and to the note about the "bootstrap" design problem.
     Think about this design problem. Are the ergonomics of Dockerfiles awkward? Yes, in my opinion, they are. This is,
     in part, just the nature of Unix/Linux, the overall ecosystem, and distributed computing.
   * Success, you are in a shell session in the container thanks to SSH!


## Notes: SSH

I have to continually learn and re-learn the basics of SSH because I don't use it frequently. I don't do much system
administration type work. It's tedious to relearn the basics from scratch so I would prefer to encode some knowledge in
this notes section and in the runnable examples in this codebase.



## Wish List

General clean ups, TODOs and things I wish to implement for this project:

* [ ] IN PROGRESS Start an SSH server. Connect to it from another container. Connect to it from my Mac host.
  * DONE start another container. I got that working but it's slow because it has to download the whole image but
    that's strange because I already have the image locally because it's the same one powering the dev container. I think
    I want to try a side-car "dev container"? UPDATE: no you can't do multi-container stuff without Docker Compose and I'm
    not interested in coupling my dev workflow to VS Code + Dev Containers + Docker Compose. That's too hat on hat. I'm
    going to do Docker-in-Docker (which is also a little hat-on-hat but at least I get control back). UPDATE: ok this works
    but there's an interesting snag with attaching/detaching from the container. A workaround is detailed in the `ssh-container-attach.sh`
    script.
  * DONE Maybe use password-based authentication? Public/private key would be better.
  * DONE (install `openssh-server` with `apt`) Debian (at least the Docker container) is pre-installed with `ssh - OpenSSH remote login client`. How should I install
    SSH server software?  
  * Configure key-based authentication. Use `ssh-copy-id`.
* [x] DONE (I installed the OpenSSH server) Install a package, or series of packages using the package manager(what is it apt-get? I always get them
  confused). UPDATE: Ok I read some docs and I was interesting in using tasksel or aptitude because are the highest level
  interactive tools for package management but they were not installed on the system. This was a little surprising. I would
  be curious to know more about these tools; are they effectively never used by the community? I'll just stick to `apt`
  which is for interactive usage. Contrast this with `apt-get` which is for scripts. So I tried `apt update` to make sure
  my copy of the list of packages and then `apt search openssh` which revealed many things, including

  > openssh-server/stable 1:8.4p1-5+deb11u1 arm64
  secure shell (SSH) server, for secure access from remote machines

  


## Reference

* [Debian Wiki: *SSH*](https://wiki.debian.org/SSH)
* [Debian Manual: *The Debian GNU/Linux FAQ* ... *Chapter 8. The Debian package management tools*](https://www.debian.org/doc/manuals/debian-faq/pkgtools.en.html)
* [Debian Manual: *Debian Reference* ... *Chapter 2. Debian package management*](https://www.debian.org/doc/manuals/debian-reference/ch02.en.html)