# Changelog
All notable changes to this project will be documented in this file.

## 1.3.5

**Bug Fix: ARM64 Baseline Binary Initialization (fixes [#7](https://github.com/magnusoverli/ha_opencode/issues/7))**

- Fixed OpenCode failing to initialize on ARM64 devices (e.g. Home Assistant Green) when using the baseline binary
  - `OPENCODE_BIN_PATH` in `opencode-session.sh` was hardcoded to the x64 baseline path — now correctly resolves based on architecture
- Added proper ARM64 detection in CPU capability check, skipping the irrelevant x86 AVX flag inspection
- Fixed potential infinite exec loop in the OpenCode wrapper fallback path
- Thanks to @timsteinberg and @Teeflo for reporting!

## 1.3.4

Re-tagged release to include the changelog in the published image (1.3.0–1.3.3 were built before the changelog was finalized).

## 1.3.3

**Architecture Refactor, CPU Compatibility, and Bug Fixes**

- Refactored s6 service architecture: initialization logic (directory setup, config generation, file deployment) now runs once in a dedicated `init-opencode` oneshot service, keeping the ttyd long-running service clean and focused
- Added CPU baseline detection for older processors without AVX2 support — the add-on now auto-detects CPU capabilities and selects the appropriate OpenCode binary (configurable via `cpu_mode`: auto/baseline/regular)
- Added custom OpenCode configuration injection — power users can now paste a JSON config in the add-on settings to customize OpenCode behavior (providers, keybindings, etc.)
- Fixed MCP `get_error_log` tool returning 404 errors by routing through the correct Supervisor proxy endpoint (`/core/api/error_log`)
- Fixed init-opencode oneshot service failing to execute (absolute path in `up` file)
- Fixed CPU auto-detection crashing on base image (replaced `grep -oP` with portable `awk`)
- Terminal banner now displays the actual add-on version instead of hardcoded "v1.0"

Inspired by work done in [okliam's fork](https://github.com/okliam). Thanks for exploring these ideas!

## 1.1.8

**New Feature: Prettier YAML Formatter + Comprehensive Style Guide**

- Added Prettier formatter for automatic YAML formatting aligned with Home Assistant conventions
- Installed globally in container and auto-configured for `.yaml`/`.yml` files
- Deploys `.prettierrc.yaml` to `/homeassistant/` on first install (user-customizable)
- Added comprehensive YAML Style Guide section to AGENTS.md covering all 13 official HA YAML formatting rules
- Style guide includes good/bad examples for each rule and marks rules Prettier cannot enforce
- AI agents now have explicit, inline guidance to write HA-compliant YAML on every change
- Reference: https://developers.home-assistant.io/docs/documenting/yaml-style-guide/

## 1.1.6

**Bug Fix: Multiple OpenCode Instances Spawning (fixes [#4](https://github.com/magnusoverli/ha_opencode/issues/4))**

- Fixed container health check failing due to missing `pgrep` (added `procps` package)
- Added `tmux` for session persistence — reconnecting now reattaches to the existing session instead of spawning a new OpenCode instance
- Prevents orphaned OpenCode processes from accumulating and consuming memory on resource-constrained devices (e.g. Raspberry Pi)

## 1.1.5

**Bug Fix: watch_firmware_update Timeout**

- Fixed `watch_firmware_update` tool timing out before returning results
- Tool now returns immediately with current status instead of blocking
- Call the tool repeatedly to monitor progress (AI can poll as needed)
- Removed unused `poll_interval` and `timeout` parameters

## 1.1.4

**Bug Fix: Update Tools Not Available**

- Fixed critical bug where update management and ESPHome tools were defined in the wrong array
- Tools `watch_firmware_update`, `get_available_updates`, `update_component`, `get_update_progress`, `get_running_jobs`, and ESPHome tools are now properly exposed
- AI assistants can now use these tools for firmware and system updates

## 1.1.3

**Documentation: Update Management Instructions**

- Added update management section to INSTRUCTIONS.md and AGENTS.md
- AI assistants now properly use `watch_firmware_update` for device updates
- Documented `get_available_updates`, `update_component`, and `get_update_progress` tools
- Added example patterns for firmware and system updates

## 1.1.2

**Build Fix: Prevent Update Race Condition**

- Fixed timing issue where updates appeared in Home Assistant before images were built
- Workflow now triggers on tag push instead of release creation
- Version in config.yaml is automatically updated after images are successfully pushed
- GitHub release is created automatically after build completes

## 1.1.1

**New Feature: Visual Firmware Update Monitoring**

- Added `watch_firmware_update` MCP tool for real-time update monitoring (MCP server v2.5)
  - Beautiful visual timeline with timestamps and status icons
  - Tracks progress from initiation through reboot to completion
  - Works with ESPHome, WLED, Zigbee coordinators, and any Home Assistant update entity
  - Automatic progress bar when device reports percentage
  - Optional `start_update` parameter to initiate update before monitoring
  - Configurable `poll_interval` (1-30s) and `timeout` (1-30min)
  - Clear success/failure summary with version change display
  - Troubleshooting tips on failure

## 1.1.0

**Infrastructure: Pre-built Docker Images**

- Add-on now uses pre-built Docker images from GitHub Container Registry
  - Update progress now visible in Home Assistant UI
  - Significantly faster updates (no local build required)
  - Images built automatically via GitHub Actions on each release
- Added CI/CD workflow for multi-architecture builds (amd64, aarch64)
- Existing users automatically migrate on update - no manual steps required

## 1.0.17

**New Feature: ESPHome Integration**

- Added 3 new MCP tools for ESPHome device management (MCP server v2.4)
  - `esphome_list_devices` - List all configured ESPHome devices with version info
  - `esphome_compile` - Compile firmware with full build log output
  - `esphome_upload` - Flash firmware to devices via OTA or USB
- Real-time build log streaming via WebSocket connection to ESPHome add-on
- Auto-discovery of ESPHome add-on via Supervisor API
- Added `ws` WebSocket dependency for ESPHome communication
- Graceful error handling when ESPHome is not installed or not running
- Build log truncation for large outputs (>300 lines)
- Helpful troubleshooting tips included on compile/upload failures

## 1.0.16

**New Feature: Update Management**

- Added 5 new MCP tools for managing Home Assistant updates (MCP server v2.3)
  - `get_available_updates` - Check for updates across Core, OS, Supervisor, and apps
  - `get_addon_changelog` - View app changelogs before updating
  - `update_component` - Initiate updates with optional backup
  - `get_update_progress` - Real-time progress monitoring with visual feedback
  - `get_running_jobs` - List all Supervisor jobs (updates, backups, restores)
- Added `callSupervisor()` API wrapper for direct Supervisor API access
- Safety guard prevents self-update from within the container (use HA UI instead)

## 1.0.15

**Build Improvements**

- Improved Dockerfile for best practices and performance
  - Use dynamic BUILD_VERSION label instead of hardcoded version
  - Add configurable OPENCODE_VERSION arg for reproducible builds
  - Fix parallel npm install with proper subshell syntax
  - Replace deprecated `--production` flag with modern `--omit=dev`
  - Remove npm audit suppression for better security visibility
  - Consolidate ENV and RUN layers for efficiency
  - Add .dockerignore to exclude unnecessary files from build context
- Fixed license in build.yaml (MIT → Unlicense)

## 1.0.14

**Terminology Update**

- Renamed "add-on" to "app" throughout the project to align with Home Assistant 2026.1 rebranding
  - Home Assistant now calls add-ons "apps" to better reflect that they are standalone applications running alongside Home Assistant
  - Updated all documentation, comments, and user-facing strings

## 1.0.13

**Bug Fixes**

- Fixed font rendering issues in web terminal (fixes #1)
  - Removed explicit fontFamily configuration from ttyd
  - Browser now uses default monospace font, avoiding letter-spacing issues when specified fonts aren't installed
  - Thanks to @pixeye33 for reporting!
- Fixed invalid JSON Schema for call_service MCP tool (fixes #2)
  - Updated target properties (entity_id, area_id, device_id) to use `oneOf` with proper `items` definition for array types
  - AI model APIs (OpenAI, Anthropic) now accept the schema without validation errors
  - Thanks to @Teeflo for the detailed bug report!

## 1.0.12

**Bug Fixes**

- Fixed MCP server API endpoint access
  - Added `callHACore()` function for direct Home Assistant Core API access
  - Fixed `get_error_log` to use correct endpoint (`/api/error_log` via Core API)
  - Some endpoints are not available via Supervisor proxy and require direct Core API access
- Improved device discovery in `get_devices` tool
  - More reliable device listing by iterating through all entity states
  - Ensures all devices are discovered, including those missed by filter-based approaches



## 1.0.11


**Bug Fixes**

- Fixed MCP server Jinja2 template bugs
  - Fixed `get_areas` template to use `namespace()` for proper list accumulation
  - Fixed `get_devices` to return device attributes (name, manufacturer, model, area)
  - Fixed `get_error_log` endpoint from `/error_log` to `/error/all`
  - Fixed `ha://areas` resource template with namespace() fix

## 1.0.10

**MCP Server Enhancements**

- Added documentation tools to MCP server v2.2 (Documentation Edition)
  - `get_integration_docs` - Fetch live documentation from Home Assistant website
  - `get_breaking_changes` - Check for breaking changes by version/integration
  - `check_config_syntax` - Validate YAML for deprecated patterns
  - Implemented HTML parsing and content extraction from HA documentation pages
  - Added deprecation pattern database for common configuration issues
  - LLMs now guided to always verify syntax against current docs before writing config
- Enhanced AGENTS.md with Home Assistant interaction guidelines
  - Added Home Assistant Interaction Model section
  - Added RESTRICTED section listing internal directories that should never be accessed
  - Provided guidance on when to use configuration files vs MCP tools


All notable changes to this project will be documented in this file.

## 1.0.9

**UI Improvements**

- Updated app icon and logo images

## 1.0.7

**New Feature**

- Added AGENTS.md customization feature
  - Default AGENTS.md file deployed to Home Assistant config directory on first install
  - Contains AI instructions and rules for OpenCode behavior
  - Users can customize AGENTS.md to add their own rules, preferences, and context
  - Edit `/config/AGENTS.md` using File Editor or any text editor
  - Includes user consent rules, Home Assistant knowledge, safety guidelines, and MCP awareness

## 1.0.6

**Documentation**

- Added LICENSE file (MIT License)
- Added repository README.md with installation instructions
- Cleaned up CHANGELOG to match repository history

## 1.0.5

**Improvements**

- Optimized Docker build process with better layer caching
  - Copy package.json files first to preserve npm install cache
  - Install MCP and LSP dependencies in parallel for faster builds
  - Code changes no longer invalidate dependency installation cache
- Simplified configuration script
  - Combined MCP and LSP configuration into single operation
  - Streamlined logging output
- Improved startup experience
  - Removed unnecessary delay before launching OpenCode

## 1.0.0

**Initial Release**

- OpenCode AI coding agent for Home Assistant
- Web terminal with ingress support
- Access to your configuration directory
- `ha-logs` command for viewing system logs
- MCP server for AI assistant integration (experimental)
- `ha-mcp` command to manage MCP integration
- Support for 75+ AI providers
- Home Assistant LSP (Language Server) for intelligent YAML editing
  - Entity ID autocomplete
  - Service autocomplete
  - Hover information for entities and services
  - Diagnostics for unknown entities/services
  - Go-to-definition for !include and !secret references