ARG BUILD_FROM
FROM $BUILD_FROM

# Environment for better Node.js performance
ENV NODE_ENV=production
ENV npm_config_update_notifier=false

# Install system dependencies
# - nodejs/npm: Required for OpenCode
# - git: Required by OpenCode for version control operations
# - jq: JSON processing for helper scripts
# - curl/ca-certificates: For downloading ttyd
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    jq \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/* \
    && npm config set fund false \
    && npm config set audit false

# Install ttyd from GitHub releases (not in Debian repos)
ARG TTYD_VERSION=1.7.7
ARG BUILD_ARCH
RUN ARCH=$([ "$BUILD_ARCH" = "aarch64" ] && echo "aarch64" || echo "x86_64") \
    && curl -fsSL "https://github.com/tsl0922/ttyd/releases/download/${TTYD_VERSION}/ttyd.${ARCH}" -o /usr/bin/ttyd \
    && chmod +x /usr/bin/ttyd

# Install OpenCode globally using official npm package
RUN npm install -g opencode-ai@latest \
    && npm cache clean --force

# Copy package.json files first for better layer caching
# Changes to server code won't invalidate npm install cache
COPY rootfs/opt/ha-mcp-server/package*.json /opt/ha-mcp-server/
COPY rootfs/opt/ha-lsp-server/package*.json /opt/ha-lsp-server/

# Install MCP and LSP dependencies in parallel
RUN cd /opt/ha-mcp-server && npm install --production --no-optional & \
    cd /opt/ha-lsp-server && npm install --production --no-optional & \
    wait && npm cache clean --force

# Copy root filesystem (server code, scripts, etc.)
COPY rootfs /

# Make scripts executable
RUN chmod +x /usr/local/bin/* \
    && chmod +x /etc/s6-overlay/s6-rc.d/ha-opencode/run

# Create directories for runtime data
RUN mkdir -p /data/.local/share/opencode \
             /data/.config/opencode

# Set working directory to HA config (mounted at runtime)
WORKDIR /homeassistant

# Health check - verify ttyd can start
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD pgrep ttyd > /dev/null || exit 1

# Labels for Home Assistant
LABEL \
    io.hass.name="HA OpenCode" \
    io.hass.description="AI coding agent for editing Home Assistant configuration" \
    io.hass.type="addon" \
    io.hass.version="1.0.0"
