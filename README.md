# oc-docker

This repository builds a lightweight OpenClaw runtime image on top of the
official base image `ghcr.io/openclaw/openclaw:latest` and adds:

- `jq`
- `rg` (ripgrep)
- `clawhub`

## Automation

GitHub Actions checks the upstream `latest` image digest every 6 hours. If the
base image digest changes, a new image is built and pushed to GHCR.

Default image name: `ghcr.io/<owner>/openclaw`

Tags:
- `base-<digest>`: bound to the upstream digest
- `base-<digest>-<run>`: unique build ID
- `latest`: always the newest wrapped image

## Usage

```bash
docker pull ghcr.io/<owner>/openclaw:latest
```

```yaml
services:
  openclaw-gateway:
    image: ghcr.io/<owner>/openclaw:latest
```

## Customize Image Name

Edit `images:` in `/.github/workflows/openclaw-image.yml`.

## Notes

- Keep this directory as a standalone Git repo so GitHub Actions can run.
