<div align="center">

# 🚀 HA OpenCode

### *AI-Powered Configuration Assistant for Home Assistant*

[![Version][version-shield]][github]
[![Project Stage][project-stage-shield]][github]
[![License][license-shield]][license]
[![Maintenance][maintenance-shield]][github]

[![aarch64][aarch64-shield]][github]
[![amd64][amd64-shield]][github]

**Transform your Home Assistant configuration with the power of AI**

[Installation](#-installation) • [Features](#-features) • [Documentation][docs] • [Support](#-support)

---

</div>

## ✨ About

**HA OpenCode** brings the revolutionary [OpenCode](https://opencode.ai) AI coding agent directly into your Home Assistant instance. Experience intelligent configuration editing through natural language, advanced YAML assistance, and deep integration via the Model Context Protocol (MCP).

Imagine having an expert Home Assistant developer available 24/7 - that's what HA OpenCode delivers. 

### 🎯 Key Features

<table>
<tr>
<td width="50%">

#### 🤖 **AI-Powered Editing**
Use natural language to modify your Home Assistant configuration. No more searching documentation - just ask!

#### 🎨 **Modern Web Terminal**
Beautiful terminal with 10 professionally designed themes, accessible directly from your HA sidebar.

#### 🔌 **Provider Agnostic**
Works with **75+ AI providers**: Anthropic, OpenAI, Google, Groq, Ollama, and many more.

</td>
<td width="50%">

#### 🔧 **Deep MCP Integration**
19 tools, 9 resources, and 6 guided prompts for comprehensive Home Assistant interaction.

#### 💡 **Intelligent LSP Support**
Smart YAML editing with entity autocomplete, live hover information, and instant diagnostics.

#### 📊 **Complete Log Access**
View Core, Supervisor, and host logs directly from the terminal.

</td>
</tr>
</table>

---

## 🌟 What is OpenCode?

[**OpenCode**](https://opencode.ai) is an open-source AI coding agent that transforms how you interact with your codebase. It understands your files, executes commands, and helps you build and maintain software using natural language.

Think of it as your personal expert developer who:
- 📖 Reads and understands your entire configuration
- ✏️ Suggests and implements improvements
- 🐛 Finds and fixes bugs automatically
- 🚀 Implements new features on request
- 💬 Explains complex configurations in plain English

---

## 🎭 Supported AI Providers

HA OpenCode works with **75+ AI providers**. Choose the one that fits your needs:

<details>
<summary><b>🔥 Popular Providers (Click to expand)</b></summary>

| Provider | Available Models |
|----------|------------------|
| 🧠 **Anthropic** | Claude 4 Opus, Claude 4 Sonnet, Claude 3.5 Sonnet, Claude 3.5 Haiku |
| 💎 **OpenAI** | GPT-4o, GPT-4 Turbo, o1, o1-mini, o3-mini |
| 🌈 **Google** | Gemini 2.0 Flash, Gemini 1.5 Pro, Gemini 1.5 Flash |
| ☁️ **AWS Bedrock** | Claude, Llama, Mistral (via AWS) |
| 🔷 **Azure OpenAI** | GPT-4, GPT-4 Turbo (Azure hosted) |
| ⚡ **Groq** | Llama 3, Mixtral (ultra-fast inference) |
| 🎯 **Mistral** | Mistral Large, Mistral Medium, Codestral |
| 🦙 **Ollama** | Local models (Llama, CodeLlama, Mistral, etc.) |
| 🌐 **OpenRouter** | 100+ models through single API |
| 🤝 **Together AI** | Llama, Mixtral, and open models |
| 🔥 **Fireworks AI** | Fast inference for open models |
| 🚀 **xAI** | Grok models |
| 💫 **Deepseek** | Deepseek Coder, Deepseek Chat |

</details>

### 🎁 **Free Tier - OpenCode Zen**

Start immediately with **OpenCode Zen** - no API keys or subscriptions required! Get access to curated models optimized for coding tasks, perfect for trying HA OpenCode or for users who prefer not to manage their own API keys.

Simply run `/connect` and select **OpenCode Zen** to get started for free.

---

## 📦 Installation

### Quick Install

1. **Add this repository to Home Assistant:**

   [![Add Repository][repo-btn]][repo-add]

   <details>
   <summary>Or add manually</summary>
   
   Go to **Settings** → **Add-ons** → **Add-on Store** → **⋮** → **Repositories**
   
   Add: `https://github.com/magnusoverli/ha_opencode`
   </details>

2. **Install the add-on:**
   - Find **"HA OpenCode"** in the add-on store
   - Click **Install**

3. **Start using it:**
   - Start the add-on
   - Click **Open Web UI** (or use the sidebar)
   - Run `opencode` and use `/connect` to configure your AI provider

---

## ⚠️ Important Security Notice

> **This add-on has read/write access to your Home Assistant configuration directory.**

While the AI is instructed to request confirmation before making changes, please:

- 💾 **Always backup** your configuration before significant changes
- 👀 **Review changes** suggested by the AI before accepting them  
- 📝 **Use version control** (git) when possible for easy rollback

---

## 📚 Documentation

Comprehensive documentation is available covering all features:

- 📖 [**Full Add-on Documentation**][docs] - Complete guide to all features
- 🔧 [**MCP Integration Guide**][docs] - 19 tools, 9 resources, 6 prompts
- 💡 [**LSP Features**][docs] - Intelligent YAML editing capabilities
- 📝 [**Changelog**][changelog] - Version history and updates

---

## 🎯 Quick Start Examples

Once installed and connected to an AI provider, try these commands:

```bash
# Create a new automation
"Create an automation that turns on lights when motion is detected"

# Review your configuration
"Check my configuration.yaml for any issues"

# Add sensors
"Add a template sensor to track my total energy usage"

# Get entity information
"What's the current state of all my lights?"

# Troubleshoot
"Why isn't my bedroom motion sensor triggering automations?"

# Analyze history
"Show me temperature trends for the past 24 hours"
```

---

## 🤝 Support

Need help? We've got you covered:

<table>
<tr>
<td align="center" width="33%">

### 💬 Discord
[Join OpenCode Discord](https://opencode.ai/discord)

Community support & discussions

</td>
<td align="center" width="33%">

### 📖 Documentation
[OpenCode Docs](https://opencode.ai/docs)

Comprehensive guides & tutorials

</td>
<td align="center" width="33%">

### 🐛 Issues
[GitHub Issues][issues]

Bug reports & feature requests

</td>
</tr>
</table>

---

## 🌟 Contributing

We love contributions! Here's how you can help:

1. 🍴 Fork the repository
2. 🔧 Create your feature branch (`git checkout -b feature/amazing-feature`)
3. 💾 Commit your changes (`git commit -m 'Add amazing feature'`)
4. 📤 Push to the branch (`git push origin feature/amazing-feature`)
5. 🎉 Open a Pull Request

See our [contributing guidelines](CONTRIBUTING.md) for more details.

---

## 👏 Authors & Contributors

<table>
<tr>
<td align="center">
<a href="https://github.com/magnusoverli">
<img src="https://github.com/magnusoverli.png" width="100px;" alt="Magnus Overli"/><br />
<sub><b>Magnus Overli</b></sub>
</a><br />
<sub>Creator & Maintainer</sub>
</td>
<td>

### All Contributors

See the [contributors page](https://github.com/magnusoverli/ha_opencode/graphs/contributors) for the full list of amazing people who have helped make this project better!

</td>
</tr>
</table>

---

## 📜 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

<div align="center">

### ⭐ If you find HA OpenCode helpful, please star this repository!

**Made with ❤️ for the Home Assistant community**

[Installation](#-installation) • [Features](#-features) • [Documentation][docs] • [Support](#-support)

</div>

<!-- Links -->
[docs]: ./ha_opencode/DOCS.md
[changelog]: ./ha_opencode/CHANGELOG.md
[issues]: https://github.com/magnusoverli/ha_opencode/issues
[license]: LICENSE
[github]: https://github.com/magnusoverli/ha_opencode
[repo-add]: https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fmagnusoverli%2Fha_opencode
[repo-btn]: https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg

<!-- Badges -->
[version-shield]: https://img.shields.io/badge/version-v1.0.12-blue.svg?style=for-the-badge
[project-stage-shield]: https://img.shields.io/badge/project%20stage-experimental-orange.svg?style=for-the-badge
[license-shield]: https://img.shields.io/github/license/magnusoverli/ha_opencode.svg?style=for-the-badge
[maintenance-shield]: https://img.shields.io/maintenance/yes/2026.svg?style=for-the-badge
[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg?style=for-the-badge
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg?style=for-the-badge
