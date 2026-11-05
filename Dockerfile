# Versions checked 2026-11-05: caddy v2.11.9 (Docker Hub 2.11 tag -> 2.11.8),
# caddy-dns/alidns v1.0.29, caddy-dns/cloudflare v0.2.4
FROM caddy:2.11-builder AS builder

LABEL maintainer="i@llm.me"
# RUN go env -w GOPROXY=https://goproxy.cn,direct

RUN xcaddy build \
    --with github.com/caddy-dns/alidns@v1.0.29 \
    --with github.com/caddy-dns/cloudflare@v0.2.4

FROM caddy:2.11

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
