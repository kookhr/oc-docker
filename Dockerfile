ARG OPENCLAW_BASE=ghcr.io/openclaw/openclaw:latest
FROM ${OPENCLAW_BASE}

ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

USER root

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        jq \
        ripgrep; \
    rm -rf /var/lib/apt/lists/*; \
    npm install -g clawhub; \
    npm cache clean --force || true

COPY scripts/patch-streamto.js /tmp/patch-streamto.js
RUN node /tmp/patch-streamto.js

USER node
