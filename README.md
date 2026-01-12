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
   - **Note**: Set `TZ` to your local timezone (e.g., `America/New_York`, `Europe/London`, `Asia/Shanghai`). The example uses `Etc/UTC` as a universal default.

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

## Testing

### Manual verification

After starting the container, verify functionality works under `no-new-privileges`:

1. **Desktop loads**: Open `http://localhost:3000` and confirm the MATE desktop renders
2. **Terminal works**: Open a terminal in the desktop and run basic commands (`ls`, `ps`, `whoami`)
3. **File operations**: Create, edit, and delete files in `/workspace` to verify CHOWN/FOWNER/DAC_OVERRIDE capabilities
4. **Process management**: Launch and close applications (e.g., text editor, file manager) to verify SETUID/SETGID capabilities

### Smoke tests (CI-friendly)

```bash
# Start container
docker compose up -d

# Wait for container to be ready
sleep 10

# Check container is running
docker compose ps | grep webtop | grep -q "Up"

# Check web interface is responding
curl -f http://localhost:3000 > /dev/null

# Check no-new-privileges is active
docker inspect webtop | grep -q "no-new-privileges:true"

# Check capabilities are correctly set
docker inspect webtop | grep -A 20 CapAdd | grep -q "CAP_CHOWN"
docker inspect webtop | grep -A 20 CapAdd | grep -q "CAP_SETUID"

# Cleanup
docker compose down
```
