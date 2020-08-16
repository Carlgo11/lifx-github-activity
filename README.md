# LIFX Tile GitHub Activity integration

[![](https://img.shields.io/github/license/carlgo11/lifx-github-activity?style=for-the-badge)](LICENSE)
[![](https://img.shields.io/github/v/release/Carlgo11/lifx-github-activity?sort=semver&style=for-the-badge)](https://github.com/Carlgo11/lifx-github-activity/releases/latest)
[![](https://img.shields.io/github/workflow/status/Carlgo11/lifx-github-activity/Docker?style=for-the-badge)](actions?query=workflow%3ADocker)
[![Docker](https://img.shields.io/badge/Docker-Download-2496ed?style=for-the-badge&logo=docker&logoColor=fff)](https://hub.docker.com/r/carlgo11/lifx/)

## Requirements

* Docker
* A LIFX Tile connected to the same network as the host

## Usage

There are two ways of controlling the LIFX Tile:

#### 1. Discover Tiles on network

```BASH
docker run -e GITHUB_USER={GitHub username} --network host carlgo11/lifx
```
\* _Change `{GitHub username}` to your own username._

#### 2. Control via IP-address

```BASH
docker run -e GITHUB_USER={GitHub username} MAC_ADDR={MAC address} IP_ADDR={IP Address} carlgo11/lifx
```
 \* _Change `{GitHub username}` to your own username._  
 \* _Change `{MAC address}` to the MAC address of the LIFX Tile._  
 \* _Change `{IP address}` to the IP address of the LIFX Tile._  
 
## Environment variables

| Name | Description | Default value |Data Type|
|------|-------------|---------------|---------|
|GITHUB_USER|GitHub Username to get activity from.| |String|
|TILE_NUMBER|LIFX Tile to connect to.|0|Integer|
|MAC_ADDR|MAC Address of the Tile.| |String|
|IP_ADDR|IP Address of the Tile.| |String|
|REVERSE|Reverse tile order.| |Boolean|
