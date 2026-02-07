# Home Assistant Community App: HA OpenCode

[![GitHub Release][releases-shield]][releases]
![Project Stage][project-stage-shield]
[![License][license-shield]][license]
[![Third-Party Licenses][third-party-shield]][third-party]

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

[![GitHub Activity][commits-shield]][commits]
![Project Maintenance][maintenance-shield]

AI-powered coding agent for Home Assistant configuration.

## About

HA OpenCode brings the power of [OpenCode](https://opencode.ai) directly to your
Home Assistant instance. Edit your configuration files using natural language,
get intelligent YAML assistance, and leverage deep Home Assistant integration
through MCP (Model Context Protocol).

### Features

- **AI-Powered Editing** — Use natural language to modify your Home Assistant
  configuration
- **Dual Access Modes** — Choose sidebar integration (quick access) or direct Web
  UI (full clipboard support)
- **Modern Web Terminal** — Beautiful terminal with 10 theme options, accessible
  from the HA sidebar
- **Native Web Interface** — OpenCode's built-in web UI with full copy/paste
  support on port 4096
- **Provider Agnostic** — Works with Anthropic, OpenAI, Google, and 70+ other
  AI providers
- **MCP Integration** — 22 tools, 9 resources, and 6 guided prompts for deep HA
  integration
- **LSP Support** — Intelligent YAML editing with entity autocomplete, hover
  info, and diagnostics
- **Log Access** — View Home Assistant Core, Supervisor, and host logs directly
- **Ingress Support** — Secure access through Home Assistant authentication

### Supported AI Providers

OpenCode supports **75+ AI providers** including:

| Provider | Models |
|----------|--------|
| **Anthropic** | Claude 4 Opus, Claude 4 Sonnet, Claude 3.5 Sonnet, Claude 3.5 Haiku |
| **OpenAI** | GPT-4o, GPT-4 Turbo, o1, o1-mini, o3-mini |
| **Google** | Gemini 2.0 Flash, Gemini 1.5 Pro, Gemini 1.5 Flash |
| **AWS Bedrock** | Claude, Llama, Mistral models via AWS |
| **Azure OpenAI** | GPT-4, GPT-4 Turbo hosted on Azure |
| **Groq** | Llama 3, Mixtral with ultra-fast inference |
| **Mistral** | Mistral Large, Mistral Medium, Codestral |
| **Ollama** | Run local models (Llama, CodeLlama, Mistral, etc.) |
| **OpenRouter** | Access to 100+ models through a single API |

...and many more including Together AI, Fireworks AI, xAI (Grok), and Deepseek.

### Free Tier

OpenCode includes **OpenCode Zen**, a free tier that lets you get started
without any API keys or subscriptions. Perfect for trying out HA OpenCode or
for users who don't want to manage their own API keys.

To use the free tier, run `/connect` and select **OpenCode Zen** as your provider.

## Warning

This app has **read/write access** to your Home Assistant configuration
directory. While the AI is instructed to ask for confirmation before making
changes, please:

- Always back up your configuration before making significant changes
- Review changes suggested by the AI before accepting them
- Keep your configuration under version control (git) when possible

## Installation

1. Click the button below to add this repository to your Home Assistant instance:

   [![Add Repository][repo-btn]][repo-add]

   Or manually add the repository URL:

   ```text
   https://github.com/magnusoverli/ha_opencode
   ```

2. Find **"HA OpenCode"** in the app store and click **Install**.

3. Start the app and click **Open Web UI** (or use the sidebar).

4. Run `opencode` and use `/connect` to configure your AI provider.

[:books: Read the full app documentation][docs]

## Support

Got questions?

- [Open an issue here][issues] on GitHub
- [OpenCode Documentation][opencode-docs]
- [OpenCode Discord][opencode-discord]

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Authors & contributors

The original setup of this repository is by [Magnus Overli][magnusoverli].

For a full list of all authors and contributors,
check [the contributor's page][contributors].

## License

This is free and unencumbered software released into the public domain.
See the [UNLICENSE](UNLICENSE) file for details.

This project uses third-party components with their own licenses.
See [THIRD-PARTY-LICENSES.md](THIRD-PARTY-LICENSES.md) for details.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[commits-shield]: https://img.shields.io/github/commit-activity/y/magnusoverli/ha_opencode.svg
[commits]: https://github.com/magnusoverli/ha_opencode/commits/main
[contributors]: https://github.com/magnusoverli/ha_opencode/graphs/contributors
[docs]: ./ha_opencode/DOCS.md
[issues]: https://github.com/magnusoverli/ha_opencode/issues
[license]: UNLICENSE
[license-shield]: https://img.shields.io/badge/license-Unlicense-blue.svg
[third-party]: THIRD-PARTY-LICENSES.md
[third-party-shield]: https://img.shields.io/badge/third--party-licenses-lightgrey.svg
[magnusoverli]: https://github.com/magnusoverli
[maintenance-shield]: https://img.shields.io/maintenance/yes/2026.svg
[opencode-discord]: https://opencode.ai/discord
[opencode-docs]: https://opencode.ai/docs
[project-stage-shield]: https://img.shields.io/badge/project%20stage-experimental-orange.svg
[releases]: https://github.com/magnusoverli/ha_opencode/releases
[releases-shield]: https://img.shields.io/github/release/magnusoverli/ha_opencode.svg
[repo-add]: https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fmagnusoverli%2Fha_opencode
[repo-btn]: https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg
