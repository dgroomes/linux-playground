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
1. Attach to the container
   * ```shell
     ./ssh-container-attach.sh
     ```
   * Start experimenting. When you want to detach from this container and return to the dev container, you need to type
     a special string of characters. Read the detailed note in `ssh-container-attach.sh`. Now, you have a substantial
     two-system Linux development and exploration environment that you can freely explore!



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
  * Maybe use password-based authentication? Public/private key would be better.
  * Debian (at least the Docker container) is pre-installed with `ssh - OpenSSH remote login client`. How should I install
  SSH server software?  
* [ ] Install a package, or series of packages using the package manager (what is it apt-get? I always get them
  confused)

## Reference

* [Debian Wiki: *SSH*](https://wiki.debian.org/SSH)