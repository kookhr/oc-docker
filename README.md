# oc-docker

This repository builds a lightweight OpenClaw runtime image on top of the
official base image `ghcr.io/openclaw/openclaw:latest` and adds:

- `jq`
- `rg` (ripgrep)
- `clawhub`

## Automation

GitHub Actions checks the upstream `latest` image digest every 6 hours.
Scheduled runs only build when `base-<digest_tag>` for the current upstream
image does not already exist in GHCR. Manual `workflow_dispatch` runs still
rebuild and push the current digest-based tags.

Default image name: `ghcr.io/<owner>/openclaw`

Tags:
- `base-<digest_tag>`: bound to the upstream digest with `sha256:` stripped
- `base-<digest_tag>-<run>`: unique build ID for that upstream digest
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

Update the `openclaw` suffix in the GHCR image references in `/.github/workflows/openclaw-image.yml`.

## Notes

- Keep this directory as a standalone Git repo so GitHub Actions can run.
