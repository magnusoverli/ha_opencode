ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base-debian:bookworm
FROM $BUILD_FROM

# Build arguments
ARG BUILD_VERSION
ARG BUILD_ARCH
ARG TTYD_VERSION=1.7.7
ARG OPENCODE_VERSION=latest
ARG BUN_VERSION=1.2.5

# Environment for better Node.js performance
ENV NODE_ENV=production \
    npm_config_update_notifier=false \
    npm_config_fund=false \
    BUN_INSTALL="/usr/local"

# Install system dependencies in a single layer
# - nodejs/npm: Required for OpenCode
# - git: Required by OpenCode for version control operations
# - jq: JSON processing for helper scripts
# - curl/ca-certificates: For downloading ttyd and bun
# - procps: Provides pgrep for health check
# - tmux: Session persistence to prevent multiple OpenCode instances
# - unzip: Required for bun installation
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        jq \
        nodejs \
        npm \
        procps \
        tmux \
        unzip \
    && rm -rf /var/lib/apt/lists/*

# Install ttyd from GitHub releases (not in Debian repos)
RUN ARCH=$([ "$BUILD_ARCH" = "aarch64" ] && echo "aarch64" || echo "x86_64") \
    && curl -fsSL "https://github.com/tsl0922/ttyd/releases/download/${TTYD_VERSION}/ttyd.${ARCH}" -o /usr/bin/ttyd \
    && chmod +x /usr/bin/ttyd

# Install bun runtime (required for oh-my-opencode)
RUN ARCH=$([ "$BUILD_ARCH" = "aarch64" ] && echo "aarch64" || echo "x86_64") \
    && curl -fsSL "https://github.com/oven-sh/bun/releases/download/bun-v${BUN_VERSION}/bun-linux-${ARCH}.zip" -o /tmp/bun.zip \
    && unzip /tmp/bun.zip -d /usr/local \
    && mv /usr/local/bun-linux-${ARCH}/bun /usr/local/bin/ \
    && rm -rf /tmp/bun.zip /usr/local/bun-linux-${ARCH}

# Install OpenCode, Prettier, and oh-my-opencode globally
# - OpenCode: AI coding agent (pin version in build.yaml for reproducible builds)
# - Prettier: Code formatter for YAML files, configured for HA conventions
# - oh-my-opencode: Enhanced agent harness with multi-model orchestration
RUN npm install -g opencode-ai@${OPENCODE_VERSION} prettier oh-my-opencode \
    && npm cache clean --force

# Copy package.json files first for better layer caching
# Changes to server code won't invalidate npm install cache
COPY rootfs/opt/ha-mcp-server/package*.json /opt/ha-mcp-server/
COPY rootfs/opt/ha-lsp-server/package*.json /opt/ha-lsp-server/

# Install MCP and LSP dependencies in parallel
RUN (cd /opt/ha-mcp-server && npm install --omit=dev) & \
    (cd /opt/ha-lsp-server && npm install --omit=dev) & \
    wait && npm cache clean --force

# Copy root filesystem (server code, scripts, etc.)
COPY rootfs /

# Make scripts executable and create runtime directories
RUN chmod +x /usr/local/bin/* \
    && chmod +x /etc/s6-overlay/s6-rc.d/init-opencode/run \
    && chmod +x /etc/s6-overlay/s6-rc.d/ha-opencode/run \
    && mkdir -p /data/.local/share/opencode /data/.config/opencode

# Set working directory to HA config (mounted at runtime)
WORKDIR /homeassistant

# Health check - verify ttyd is running
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD pgrep ttyd > /dev/null || exit 1

# Labels for Home Assistant
LABEL \
    io.hass.name="HA OpenCode" \
    io.hass.description="AI coding agent for editing Home Assistant configuration" \
    io.hass.type="addon" \
    io.hass.version="${BUILD_VERSION}"
