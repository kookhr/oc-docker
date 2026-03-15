ARG OPENCLAW_BASE=ghcr.io/openclaw/openclaw:latest
FROM ${OPENCLAW_BASE}

ARG OPENCLAW_BASE_DIGEST=

LABEL org.opencontainers.image.base.name=$OPENCLAW_BASE \
  org.opencontainers.image.base.digest=$OPENCLAW_BASE_DIGEST

RUN set -e; \
  if command -v apt-get >/dev/null 2>&1; then \
    apt-get update \
      && apt-get install -y --no-install-recommends jq ripgrep \
      && rm -rf /var/lib/apt/lists/*; \
  elif command -v apk >/dev/null 2>&1; then \
    apk add --no-cache jq ripgrep; \
  else \
    echo "No supported package manager found" >&2; \
    exit 1; \
  fi; \
  if command -v npm >/dev/null 2>&1; then \
    npm install -g clawhub; \
    npm cache clean --force >/dev/null 2>&1 || true; \
  else \
    echo "npm not found in base image" >&2; \
    exit 1; \
  fi
