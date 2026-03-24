# oc-docker

This repository builds a lightweight OpenClaw runtime image on top of the
official base image `ghcr.io/openclaw/openclaw:latest` and adds:

- `jq`
- `rg` (ripgrep)
- `clawhub`

## Automation

GitHub Actions checks the upstream `latest` image digest every 2 days at 00:15 UTC.
Scheduled runs only build when `base-<digest_tag>` for the current upstream
image does not already exist in GHCR. Manual `workflow_dispatch` runs still
rebuild and push the current digest-based tags. Published tags stay tied to the
upstream image digest, with `latest` always pointing at the newest wrapped image
for that upstream base.

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

Update `upstream_repo` in `./.github/workflows/openclaw-image.yml` if you need
to track a different upstream image. The published image name remains
`ghcr.io/<owner>/openclaw`.

## Notes

- Keep this directory as a standalone Git repo so GitHub Actions can run.
