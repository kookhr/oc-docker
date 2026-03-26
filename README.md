# oc-docker

This repository builds a lightweight OpenClaw runtime image on top of the
official base image `ghcr.io/openclaw/openclaw:latest` and adds:

- `jq`
- `rg` (ripgrep)
- `clawhub`

## Automation

GitHub Actions checks the upstream `latest` image digest every hour at minute 15 UTC.
Scheduled runs only build when your published `latest` image was built from a
different upstream digest. Manual `workflow_dispatch` runs still force rebuild
and push.

Default image name: `ghcr.io/<owner>/openclaw`

Tags:
- `latest`: aligned with the upstream tracked tag (`latest`)

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
