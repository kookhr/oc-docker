ARG OPENCLAW_BASE=ghcr.io/openclaw/openclaw:latest
FROM ${OPENCLAW_BASE}

LABEL org.opencontainers.image.base.name=$OPENCLAW_BASE

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        jq \
        ripgrep; \
    rm -rf /var/lib/apt/lists/*; \
    npm install -g clawhub; \
    npm cache clean --force || true