# docker-ubuntu-powershell

Ubuntu based image with latest (auto-build) of Ubuntu plus Powershell with PSReadline configured for Tab key to MenuComplete and some common key bindings Windows PowerShell users are accustomed to.

[![DockerPulls](https://img.shields.io/docker/pulls/tolgabalci/ubuntu-powershell.svg)](https://registry.hub.docker.com/r/tolgabalci/ubuntu-powershell/)
[![DockerStars](https://img.shields.io/docker/stars/tolgabalci/ubuntu-powershell.svg)](https://registry.hub.docker.com/r/tolgabalci/ubuntu-powershell/)

This repository contains a Docker file to build a Docker image for a developer environment. Compatible as a VSCode Dev Container.

## Pull the image from Docker Repository

```
docker pull tolgabalci/ubuntu-powershell
```

## Run the image from Docker Repository

- You can use this image for your VSCode Dev Container or
- You can run it directly:

```
docker run -it tolgabalci/ubuntu-powershell
```

## Build your own version of the image

```
docker build --rm -t <hub-user>/ubuntu-powershell .
```

## Push your own version of the image to Docker Hub

\$ docker push <hub-user>/ubuntu-powershell
