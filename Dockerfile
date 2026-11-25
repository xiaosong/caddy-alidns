# Versions checked 2026-11-25: caddy 2.11 tag -> 2.11.9 (pinned to major.minor
# on purpose so patch releases flow in on rebuild), caddy-dns/alidns v1.0.29,
# caddy-dns/cloudflare v0.2.4
FROM --platform=$BUILDPLATFORM caddy:2.11-builder AS builder

ARG TARGETOS
ARG TARGETARCH

# RUN go env -w GOPROXY=https://goproxy.cn,direct

RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} xcaddy build \
    --with github.com/caddy-dns/alidns@v1.0.29 \
    --with github.com/caddy-dns/cloudflare@v0.2.4

FROM caddy:2.11

LABEL maintainer="i@llm.me"

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
