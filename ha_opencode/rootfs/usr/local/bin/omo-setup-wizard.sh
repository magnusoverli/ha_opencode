#!/usr/bin/env bash
# =============================================================================
# Oh-My-OpenCode Setup Wizard
# Interactive subscription configuration for oh-my-opencode
# =============================================================================

set -e

# Set up home directory for persistent storage
export HOME="/data"
export XDG_DATA_HOME="/data/.local/share"
export XDG_CONFIG_HOME="/data/.config"

# Ensure directories exist
mkdir -p "${HOME}/.config/opencode"
mkdir -p "${HOME}/.local/share/opencode"

# Marker file to track setup completion
MARKER_FILE="${HOME}/.config/opencode/.omo-setup-complete"
CONFIG_FILE="${HOME}/.config/opencode/oh-my-opencode.json"
OPENCODE_CONFIG="${HOME}/.config/opencode/opencode.json"

# Colors
BOLD='\033[1m'
BLUE='\033[38;2;29;153;243m'
GREEN='\033[38;2;17;209;22m'
YELLOW='\033[38;2;246;116;0m'
CYAN='\033[38;2;26;188;156m'
RED='\033[38;2;237;21;21m'
WHITE='\033[38;2;252;252;252m'
GRAY='\033[38;2;127;140;141m'
NC='\033[0m'

# Clear screen and show header
clear
echo ""
echo -e "${CYAN}${BOLD}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}${BOLD}║${NC}${WHITE}${BOLD}         Oh-My-OpenCode Subscription Setup                ${NC}${CYAN}${BOLD}║${NC}"
echo -e "${CYAN}${BOLD}╠══════════════════════════════════════════════════════════╣${NC}"
echo -e "${CYAN}${BOLD}║${NC}                                                          ${CYAN}${BOLD}║${NC}"
echo -e "${CYAN}${BOLD}║${NC}${GRAY}  This wizard configures your AI provider subscriptions   ${NC}${CYAN}${BOLD}║${NC}"
echo -e "${CYAN}${BOLD}║${NC}${GRAY}  for the best agent experience with oh-my-opencode.      ${NC}${CYAN}${BOLD}║${NC}"
echo -e "${CYAN}${BOLD}║${NC}                                                          ${CYAN}${BOLD}║${NC}"
echo -e "${CYAN}${BOLD}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check if already configured
if [ -f "${MARKER_FILE}" ]; then
    echo -e "${YELLOW}Oh-My-OpenCode has already been configured.${NC}"
    echo -e "${GRAY}Running this wizard again will update your settings.${NC}"
    echo ""
    read -p "Continue anyway? [y/N]: " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${GRAY}Setup cancelled.${NC}"
        exit 0
    fi
    echo ""
fi

# Function to ask yes/no question
ask_yes_no() {
    local prompt="$1"
    local default="${2:-n}"
    local result=""
    
    if [ "$default" = "y" ]; then
        prompt="${prompt} [Y/n]: "
    else
        prompt="${prompt} [y/N]: "
    fi
    
    while true; do
        read -p "$prompt" -n 1 -r
        echo ""
        if [[ -z "$REPLY" ]]; then
            result="$default"
        elif [[ $REPLY =~ ^[Yy]$ ]]; then
            result="y"
        elif [[ $REPLY =~ ^[Nn]$ ]]; then
            result="n"
        else
            echo -e "${RED}Please enter y or n${NC}"
            continue
        fi
        break
    done
    
    echo "$result"
}

# Collect subscription information
CLAUDE_SETTING="no"
OPENAI_SETTING="no"
GEMINI_SETTING="no"
COPILOT_SETTING="no"
OPENCODE_ZEN_SETTING="no"
ZAI_SETTING="no"

echo -e "${WHITE}${BOLD}Subscription Questions${NC}"
echo -e "${GRAY}────────────────────────────────────────────────────────────${NC}"
echo ""

# Claude subscription
echo -e "${BOLD}1. Do you have a Claude Pro/Max Subscription?${NC}"
REPLY=$(ask_yes_no "   " "n")
if [ "$REPLY" = "y" ]; then
    echo -e "${GRAY}   Are you on max20 (20x mode)?${NC}"
    MAX_REPLY=$(ask_yes_no "   " "n")
    if [ "$MAX_REPLY" = "y" ]; then
        CLAUDE_SETTING="max20"
    else
        CLAUDE_SETTING="yes"
    fi
fi
echo ""

# OpenAI subscription
echo -e "${BOLD}2. Do you have an OpenAI/ChatGPT Plus Subscription?${NC}"
REPLY=$(ask_yes_no "   (GPT-5.2 for Oracle agent)" "n")
if [ "$REPLY" = "y" ]; then
    OPENAI_SETTING="yes"
fi
echo ""

# Gemini subscription
echo -e "${BOLD}3. Will you integrate Gemini models?${NC}"
REPLY=$(ask_yes_no "   " "n")
if [ "$REPLY" = "y" ]; then
    GEMINI_SETTING="yes"
fi
echo ""

# GitHub Copilot
echo -e "${BOLD}4. Do you have a GitHub Copilot Subscription?${NC}"
REPLY=$(ask_yes_no "   (Fallback provider)" "n")
if [ "$REPLY" = "y" ]; then
    COPILOT_SETTING="yes"
fi
echo ""

# OpenCode Zen
echo -e "${BOLD}5. Do you have access to OpenCode Zen (opencode/ models)?${NC}"
REPLY=$(ask_yes_no "   " "n")
if [ "$REPLY" = "y" ]; then
    OPENCODE_ZEN_SETTING="yes"
fi
echo ""

# Z.ai Coding Plan
echo -e "${BOLD}6. Do you have a Z.ai Coding Plan subscription?${NC}"
REPLY=$(ask_yes_no "   (GLM-4.7 for Librarian agent)" "n")
if [ "$REPLY" = "y" ]; then
    ZAI_SETTING="yes"
fi
echo ""

# Warn if no subscriptions
if [ "$CLAUDE_SETTING" = "no" ] && [ "$OPENAI_SETTING" = "no" ] && \
   [ "$GEMINI_SETTING" = "no" ] && [ "$COPILOT_SETTING" = "no" ] && \
   [ "$OPENCODE_ZEN_SETTING" = "no" ] && [ "$ZAI_SETTING" = "no" ]; then
    echo -e "${YELLOW}${BOLD}Warning: No subscriptions selected.${NC}"
    echo -e "${YELLOW}The Sisyphus agent requires Claude for optimal performance.${NC}"
    echo ""
    REPLY=$(ask_yes_no "Continue without subscriptions?" "n")
    if [ "$REPLY" != "y" ]; then
        echo -e "${GRAY}Setup cancelled.${NC}"
        exit 0
    fi
fi

# Build the install command
INSTALL_CMD="bunx oh-my-opencode install --no-tui"
INSTALL_CMD="${INSTALL_CMD} --claude=${CLAUDE_SETTING}"
INSTALL_CMD="${INSTALL_CMD} --gemini=${GEMINI_SETTING}"
INSTALL_CMD="${INSTALL_CMD} --copilot=${COPILOT_SETTING}"

if [ "$OPENAI_SETTING" = "yes" ]; then
    INSTALL_CMD="${INSTALL_CMD} --openai=yes"
else
    INSTALL_CMD="${INSTALL_CMD} --openai=no"
fi

if [ "$OPENCODE_ZEN_SETTING" = "yes" ]; then
    INSTALL_CMD="${INSTALL_CMD} --opencode-zen=yes"
else
    INSTALL_CMD="${INSTALL_CMD} --opencode-zen=no"
fi

if [ "$ZAI_SETTING" = "yes" ]; then
    INSTALL_CMD="${INSTALL_CMD} --zai-coding-plan=yes"
else
    INSTALL_CMD="${INSTALL_CMD} --zai-coding-plan=no"
fi

# Show summary and run installer
echo -e "${WHITE}${BOLD}Configuration Summary${NC}"
echo -e "${GRAY}────────────────────────────────────────────────────────────${NC}"
echo ""
echo -e "  Claude:        ${CYAN}${CLAUDE_SETTING}${NC}"
echo -e "  OpenAI:        ${CYAN}${OPENAI_SETTING}${NC}"
echo -e "  Gemini:        ${CYAN}${GEMINI_SETTING}${NC}"
echo -e "  GitHub Copilot:${CYAN}${COPILOT_SETTING}${NC}"
echo -e "  OpenCode Zen:  ${CYAN}${OPENCODE_ZEN_SETTING}${NC}"
echo -e "  Z.ai Coding:   ${CYAN}${ZAI_SETTING}${NC}"
echo ""
echo -e "${GRAY}Running installer...${NC}"
echo ""
echo -e "${GRAY}→ ${INSTALL_CMD}${NC}"
echo ""

# Run the installer
cd /homeassistant
if $INSTALL_CMD; then
    echo ""
    echo -e "${GREEN}${BOLD}✓ Oh-My-OpenCode configured successfully!${NC}"
    
    # Create marker file
    touch "${MARKER_FILE}"
    
    # Store settings in marker for reference
    cat > "${MARKER_FILE}" << EOF
# Oh-My-OpenCode Setup - Completed $(date -Iseconds)
CLAUDE=${CLAUDE_SETTING}
OPENAI=${OPENAI_SETTING}
GEMINI=${GEMINI_SETTING}
COPILOT=${COPILOT_SETTING}
OPENCODE_ZEN=${OPENCODE_ZEN_SETTING}
ZAI_CODING_PLAN=${ZAI_SETTING}
EOF
    
    # Show authentication instructions
    echo ""
    echo -e "${CYAN}${BOLD}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}${BOLD}║${NC}${WHITE}${BOLD}  IMPORTANT: Authentication Required                      ${NC}${CYAN}${BOLD}║${NC}"
    echo -e "${CYAN}${BOLD}╠══════════════════════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}${BOLD}║${NC}                                                          ${NC}${CYAN}${BOLD}║${NC}"
    echo -e "${CYAN}${BOLD}║${NC}${GRAY}  Run ${NC}${GREEN}opencode auth login${NC}${GRAY} to authenticate your providers:  ${NC}${CYAN}${BOLD}║${NC}"
    echo -e "${CYAN}${BOLD}║${NC}                                                          ${NC}${CYAN}${BOLD}║${NC}"
    
    if [ "$CLAUDE_SETTING" != "no" ]; then
        echo -e "${CYAN}${BOLD}║${NC}  ${YELLOW}•${NC} ${WHITE}Claude:${NC} Select Anthropic → Claude Pro/Max        ${CYAN}${BOLD}║${NC}"
    fi
    if [ "$OPENAI_SETTING" = "yes" ]; then
        echo -e "${CYAN}${BOLD}║${NC}  ${YELLOW}•${NC} ${WHITE}OpenAI:${NC} Select OpenAI → API key or OAuth       ${CYAN}${BOLD}║${NC}"
    fi
    if [ "$GEMINI_SETTING" = "yes" ]; then
        echo -e "${CYAN}${BOLD}║${NC}  ${YELLOW}•${NC} ${WHITE}Gemini:${NC} Select Google → OAuth (Antigravity)    ${CYAN}${BOLD}║${NC}"
    fi
    if [ "$COPILOT_SETTING" = "yes" ]; then
        echo -e "${CYAN}${BOLD}║${NC}  ${YELLOW}•${NC} ${WHITE}Copilot:${NC} Select GitHub → OAuth                  ${CYAN}${BOLD}║${NC}"
    fi
    
    echo -e "${CYAN}${BOLD}║${NC}                                                          ${NC}${CYAN}${BOLD}║${NC}"
    echo -e "${CYAN}${BOLD}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
else
    echo ""
    echo -e "${RED}${BOLD}✗ Installation failed.${NC}"
    echo -e "${GRAY}Please check the error messages above and try again.${NC}"
    exit 1
fi
