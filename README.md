# ubuntu-dev-desktop-container

Reproducible Ubuntu GUI development environment using containers (webtop), designed for isolated, disposable, and AI-assisted development workflows.

This repository runs an Ubuntu MATE desktop in your browser using `lscr.io/linuxserver/webtop:ubuntu-mate`.

## Build image

This project now builds a local image with a minimal tooling layer on top of `lscr.io/linuxserver/webtop:ubuntu-mate`.
Node.js and npm are installed from the Ubuntu official repositories to avoid external setup scripts and keep installs reliable behind mainland China mirrors.

Build args:

- `APT_MIRROR` (default `mirrors.aliyun.com`) for mainland China acceleration. Example: `mirrors.tuna.tsinghua.edu.cn`.

Build command:

```bash
docker compose build
```

## Requirements

- Windows 11/10 with WSL2
- Docker Desktop with WSL integration enabled
- Docker Compose v2 (`docker compose`)

## Quick start

1) Create `.env` from the example and fill in your values:

```bash
cp .env.example .env
```

2) Edit `.env` and set `PUID`, `PGID`, and `TZ` for your user.

3) Start the container:

```bash
docker compose up -d
```

4) Open the desktop in your browser:

- URL: `http://localhost:${WEBTOP_PORT}` (default `3000`)

If `localhost` does not work in your Windows browser, try the WSL2 IP or ensure Docker Desktop WSL integration is enabled.

## Volumes

- `config` -> `/config` (webtop configuration and persistence)
- `workspace` -> `/workspace` (project workspace inside the container)

## Verify tool versions

Start the container if it is not already running:

```bash
docker compose up -d
```

Verify core tools inside the container:

```bash
docker compose exec -T webtop git --version
docker compose exec -T webtop node --version
docker compose exec -T webtop python3 --version
```

Expected output (examples):

- `git version 2.x`
- `v18.x.x` (Ubuntu default for 24.04 at the time of writing)
- `Python 3.x.x`

## Stop and remove

```bash
docker compose down
```

To delete the persistent data, remove the `config` and `workspace` directories (or the named volumes if you switch to volumes).

## Acceptance (this change)

Commands:

```bash
docker compose build
docker compose up -d
docker compose exec -T webtop npm --version
```

Expected output:

- build completes without errors
- container is running
- `npm` prints a version number (e.g., `9.x.x`)
