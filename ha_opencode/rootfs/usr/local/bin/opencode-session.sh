#!/usr/bin/env bash
# =============================================================================
# OpenCode Session - Wrapper script that runs inside ttyd
# =============================================================================

# Set up home directory for persistent storage
export HOME="/data"
export XDG_DATA_HOME="/data/.local/share"
export XDG_CONFIG_HOME="/data/.config"

# Ensure SUPERVISOR_TOKEN is available for MCP server
# This is auto-injected by Home Assistant Supervisor
if [ -z "$SUPERVISOR_TOKEN" ]; then
    echo "Warning: SUPERVISOR_TOKEN not set. MCP integration may not work."
fi

# Ensure directories exist
mkdir -p "${HOME}/.local/share/opencode"
mkdir -p "${HOME}/.config/opencode"

# KDE Breeze-style colors
BLUE='\\033[38;2;29;153;243m'
GREEN='\\033[38;2;17;209;22m'
YELLOW='\\033[38;2;246;116;0m'
CYAN='\\033[38;2;26;188;156m'
WHITE='\\033[38;2;252;252;252m'
GRAY='\\033[38;2;127;140;141m'
BOLD='\\033[1m'
NC='\\033[0m'

CPU_MODE=$(cat /data/.cpu_mode 2>/dev/null || echo "unknown")
CPU_INFO=""
if [ "${CPU_MODE}" = "baseline" ]; then
    CPU_INFO=" ${YELLOW}(baseline CPU mode)${NC}"
fi

# Change to Home Assistant config directory
cd /homeassistant

# Set up PATH - ensure node, npm globals, and standard bins are available
export PATH="/usr/local/bin:/usr/bin:/bin:$PATH"

# Configure git if not already configured
if [ ! -f "${HOME}/.gitconfig" ]; then
    git config --global init.defaultBranch main 2>/dev/null || true
    git config --global safe.directory /homeassistant 2>/dev/null || true
fi

# Function to show welcome banner
show_banner() {
    clear
    echo ""
    echo -e "${BLUE}${BOLD}HA OpenCode${NC} ${GRAY}v1.0${NC}${CPU_INFO}"
    echo -e "${GRAY}AI-powered coding agent for Home Assistant${NC}"
    echo ""
    echo -e "${GRAY}────────────────────────────────────────────────────────────${NC}"
    echo ""
}

show_banner

echo -e "${WHITE}Working directory:${NC} ${CYAN}/homeassistant${NC}"
echo -e "${GRAY}First time? Use ${NC}${GREEN}/connect${NC} ${GRAY}inside OpenCode to add your AI provider${NC}"
echo -e "${GRAY}Customize AI behavior by editing ${NC}${GREEN}AGENTS.md${NC} ${GRAY}in your config folder${NC}"
echo ""

opencode

echo ""
echo -e "${GRAY}────────────────────────────────────────────────────────────${NC}"
echo ""
echo -e "${WHITE}OpenCode exited.${NC} Working directory: ${CYAN}/homeassistant${NC}"
echo ""
echo -e "${BOLD}Commands${NC}"
echo -e "  ${GREEN}opencode${NC}          Restart the AI coding agent"
echo -e "  ${GREEN}ha${NC} ${GRAY}<cmd>${NC}         Home Assistant CLI (restart, logs, etc)"
echo ""

exec bash --login
