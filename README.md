# ubuntu-dev-desktop-container

Reproducible Ubuntu GUI development environment using containers (webtop), designed for isolated, disposable, and AI-assisted development workflows.

This repository runs an Ubuntu MATE desktop in your browser using `lscr.io/linuxserver/webtop:ubuntu-mate`.

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

## Stop and remove

```bash
docker compose down
```

To delete the persistent data, remove the `config` and `workspace` directories (or the named volumes if you switch to volumes).
