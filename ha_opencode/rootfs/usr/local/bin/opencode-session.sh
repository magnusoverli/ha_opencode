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

# Marker file for oh-my-opencode setup
OMO_MARKER="${HOME}/.config/opencode/.omo-setup-complete"

# KDE Breeze-style colors
BLUE='\033[38;2;29;153;243m'
GREEN='\033[38;2;17;209;22m'
YELLOW='\033[38;2;246;116;0m'
CYAN='\033[38;2;26;188;156m'
WHITE='\033[38;2;252;252;252m'
GRAY='\033[38;2;127;140;141m'
BOLD='\033[1m'
NC='\033[0m'

# Read addon version and CPU mode written by init-opencode
CPU_MODE=$(cat /data/.cpu_mode 2>/dev/null || echo "unknown")
ADDON_VERSION=$(cat /data/.addon_version 2>/dev/null || echo "unknown")
CPU_INFO=""
if [ "${CPU_MODE}" = "baseline" ]; then
    CPU_INFO=" ${YELLOW}(baseline CPU mode)${NC}"
    case $(uname -m) in
        x86_64)
            export OPENCODE_BIN_PATH="/usr/local/lib/node_modules/opencode-linux-x64-baseline/bin/opencode"
            ;;
        aarch64|arm64)
            export OPENCODE_BIN_PATH="/usr/local/lib/node_modules/opencode-linux-arm64-baseline/bin/opencode"
            ;;
    esac
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
    echo -e "${BLUE}${BOLD}HA OpenCode${NC} ${GRAY}v${ADDON_VERSION}${NC}${CPU_INFO}"
    echo -e "${GRAY}AI-powered coding agent for Home Assistant${NC}"
    echo ""
    echo -e "${GRAY}────────────────────────────────────────────────────────────${NC}"
    echo ""
}

# Function to show menu
show_menu() {
    local omo_status=""
    if [ -f "${OMO_MARKER}" ]; then
        omo_status="${GREEN}(configured)${NC}"
    else
        omo_status="${YELLOW}(recommended)${NC}"
    fi
    
    echo -e "${WHITE}${BOLD}Main Menu${NC}"
    echo ""
    echo -e "  ${GREEN}1${NC}) Launch OpenCode"
    echo -e "  ${GREEN}2${NC}) Configure Oh-My-OpenCode ${omo_status}"
    echo -e "  ${GREEN}3${NC}) Drop to shell"
    echo ""
}

# Function to show shell help (after exiting opencode)
show_shell_help() {
    echo ""
    echo -e "${GRAY}────────────────────────────────────────────────────────────${NC}"
    echo ""
    echo -e "${WHITE}Dropped to shell.${NC} Working directory: ${CYAN}/homeassistant${NC}"
    echo ""
    echo -e "${BOLD}Commands${NC}"
    echo -e "  ${GREEN}opencode${NC}          Start the AI coding agent"
    echo -e "  ${GREEN}omo-wizard${NC}        Run Oh-My-OpenCode setup wizard"
    echo -e "  ${GREEN}ha-logs${NC} ${GRAY}<type>${NC}    View logs (core, error, supervisor, host)"
    echo -e "  ${GREEN}ha-mcp${NC} ${GRAY}<cmd>${NC}     MCP integration (enable, disable, status)"
    echo ""
}

# Function to launch opencode
launch_opencode() {
    show_banner
    echo -e "${WHITE}Working directory:${NC} ${CYAN}/homeassistant${NC}"
    
    if [ ! -f "${OMO_MARKER}" ]; then
        echo -e "${YELLOW}Tip: Run option 2 to configure Oh-My-OpenCode for enhanced features.${NC}"
        echo ""
    fi
    
    echo -e "${GRAY}First time? Use ${NC}${GREEN}/connect${NC} ${GRAY}inside OpenCode to add your AI provider${NC}"
    echo -e "${GRAY}Customize AI behavior by editing ${NC}${GREEN}AGENTS.md${NC} ${GRAY}in your config folder${NC}"
    echo ""
    
    opencode
    
    # When opencode exits, show help and drop to bash
    show_shell_help
    exec bash --login
}

# Function to run setup wizard
run_omo_wizard() {
    omo-setup-wizard.sh
    echo ""
    echo -e "${GRAY}Press any key to return to menu...${NC}"
    read -n 1 -s
}

# Function to drop to shell
drop_to_shell() {
    show_banner
    show_shell_help
    exec bash --login
}

# Main loop
while true; do
    show_banner
    show_menu
    
    echo -e "${WHITE}Enter choice ${GRAY}[1-3]${NC}:${NC} "
    read -n 1 -r choice
    echo ""
    
    case $choice in
        1)
            launch_opencode
            exit 0
            ;;
        2)
            run_omo_wizard
            ;;
        3)
            drop_to_shell
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option. Please enter 1, 2, or 3.${NC}"
            sleep 1
            ;;
    esac
done
