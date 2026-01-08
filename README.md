# Home Assistant Add-on: HA OpenCode

![Version][version-shield]
![Project Stage][project-stage-shield]
[![License][license-shield]](LICENSE)
![Maintenance][maintenance-shield]
![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

AI-powered coding agent for Home Assistant configuration.

## About This Add-on

HA OpenCode brings the power of OpenCode directly to your Home Assistant instance. Edit your configuration files using natural language, get intelligent YAML assistance, and leverage deep Home Assistant integration through MCP (Model Context Protocol).

### Key Features

- **AI-Powered Editing** - Use natural language to modify your Home Assistant configuration
- **Modern Web Terminal** - Beautiful terminal with 10 theme options, accessible from the HA sidebar
- **Provider Agnostic** - Works with Anthropic, OpenAI, Google, and 70+ other AI providers
- **MCP Integration** - 19 tools, 9 resources, and 6 guided prompts for deep HA integration
- **LSP Support** - Intelligent YAML editing with entity autocomplete, hover info, and diagnostics
- **Log Access** - View Home Assistant Core, Supervisor, and host logs directly
- **Ingress Support** - Secure access through Home Assistant authentication

## What is OpenCode?

[OpenCode](https://opencode.ai) is an open-source AI coding agent that runs in your terminal. It understands your codebase, can edit files, run commands, and help you build software using natural language. Think of it as having an expert developer available 24/7 who can read your code, suggest improvements, fix bugs, and implement features.

OpenCode works by connecting to large language models (LLMs) from various providers and giving them the ability to interact with your local filesystem, execute commands, and understand context from your project.

### Supported AI Providers & Models

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
| **Together AI** | Llama, Mixtral, and other open models |
| **Fireworks AI** | Fast inference for open models |
| **xAI** | Grok models |
| **Deepseek** | Deepseek Coder, Deepseek Chat |

### Free Tier - OpenCode Zen

OpenCode includes **OpenCode Zen**, a free tier that lets you get started without any API keys or subscriptions. Zen provides access to curated models optimized for coding tasks - perfect for trying out HA OpenCode or for users who don't want to manage their own API keys.

To use the free tier, simply run `/connect` and select **OpenCode Zen** as your provider.

[:books: Read the full add-on documentation][addon-doc-ha-opencode]

## Warning

This add-on has **read/write access** to your Home Assistant configuration directory. While the AI is instructed to ask for confirmation before making changes, please:

- Always back up your configuration before making significant changes
- Review changes suggested by the AI before accepting them
- Keep your configuration under version control (git) when possible

## Installation

1. Click the button below to add this repository to your Home Assistant instance:

   [![Add Repository][repo-btn]][repo-add]

   Or manually add the repository URL:
   ```
   https://github.com/magnusoverli/ha_opencode
   ```

2. Find **"HA OpenCode"** in the add-on store and click **Install**.

3. Start the add-on and click **Open Web UI** (or use the sidebar).

4. Run `opencode` and use `/connect` to configure your AI provider.

## Add-ons in this repository

### &#10003; [HA OpenCode][addon-ha-opencode]

AI coding agent for editing Home Assistant configuration with intelligent YAML assistance.

[:books: HA OpenCode documentation][addon-doc-ha-opencode]

## Support

Got questions or issues?

- [Open an issue on GitHub][issues]
- [OpenCode Documentation](https://opencode.ai/docs)
- [OpenCode Discord](https://opencode.ai/discord)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Authors & Contributors

- **Magnus Overli** - *Initial work* - [magnusoverli](https://github.com/magnusoverli)

See the [contributors](https://github.com/magnusoverli/ha_opencode/graphs/contributors) page for a full list of contributors.

## License

MIT License - see [LICENSE](LICENSE) for details.

[addon-ha-opencode]: ./ha_opencode
[addon-doc-ha-opencode]: ./ha_opencode/DOCS.md
[issues]: https://github.com/magnusoverli/ha_opencode/issues
[repo-add]: https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fmagnusoverli%2Fha_opencode
[repo-btn]: https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg

[version-shield]: https://img.shields.io/badge/version-v1.0.12-blue.svg
[project-stage-shield]: https://img.shields.io/badge/project%20stage-experimental-orange.svg
[license-shield]: https://img.shields.io/github/license/magnusoverli/ha_opencode.svg
[maintenance-shield]: https://img.shields.io/maintenance/yes/2026.svg
[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
