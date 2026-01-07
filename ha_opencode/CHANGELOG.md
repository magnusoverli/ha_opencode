# Changelog

All notable changes to this project will be documented in this file.

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
