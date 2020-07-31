# LIFX Tile GitHub Activity integration

![](https://img.shields.io/github/license/carlgo11/lifx-github-activity?style=for-the-badge)
![](https://img.shields.io/github/v/release/Carlgo11/lifx-github-activity?sort=semver&style=for-the-badge)
![](https://img.shields.io/github/workflow/status/Carlgo11/lifx-github-activity/Docker?style=for-the-badge)

## Requirements

* Docker
* A LIFX Tile connected to the same network as the host

## Usage

```BASH
docker run -e {github username} --network host carlgo11/lifx
```
Change `{github username}` to your own username.

## Environment variables
| Name | Description | Default value |
|------|-------------|---------------|
|GITHUB_USER|GitHub Username to get activity from.||
|TILE_NUMBER|LIFX Tile to connect to.|0|
|MAC_ADDR|Mac Address of the Tile (Optional)||
|IP_ADDR|IP Address of the Tile (Optional)||
