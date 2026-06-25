# Claude Code Skills for CMUX

![macOS](https://img.shields.io/badge/macOS-required-000000?logo=apple&logoColor=white)
![cmux](https://img.shields.io/badge/cmux-required-5865F2)
![Claude Code](https://img.shields.io/badge/Claude%20Code-required-D97757?logo=anthropic&logoColor=white)
![git](https://img.shields.io/badge/git-required-F05032?logo=git&logoColor=white)
![bash](https://img.shields.io/badge/bash-required-4EAA25?logo=gnubash&logoColor=white)
![python3](https://img.shields.io/badge/python3-required-3776AB?logo=python&logoColor=white)

This repository is a versioned collection of [Claude Code](https://claude.com/claude-code) skills that teach Claude how to operate inside [cmux](https://cmux.com), a terminal multiplexer for macOS. Each skill is a self-contained `SKILL.md` document that Claude reads as context, giving it working knowledge of cmux's environment, CLI, and automation surface — orientation within the window/workspace/pane/surface hierarchy, non-disruptive workspace automation, browser panel control, multi-agent coordination via Claude Teams, and configuration management.

The repository also ships `cmux-claude`, a command-line tool for installing, updating, and managing these skills across your machine or individual projects.

## Installation

Clone the repository and run the installer. This makes the `cmux-claude` CLI executable and symlinks it into `/usr/local/bin` so it is available globally on your system.

```bash
git clone https://github.com/andreyabpaiva/claude-cmux-skills.git
cd claude-cmux-skills
bash install.sh
```

If `/usr/local/bin` is not on your `PATH`, the installer will tell you and provide the line to add to your shell profile.

## Usage

Once installed, skills are managed entirely through the `cmux-claude` command.

| Command | Description |
|---|---|
| `cmux-claude install` | Install all skills globally (`~/.claude/skills`) |
| `cmux-claude install --project` | Install all skills to the current project (`.claude/skills`) |
| `cmux-claude install --category <name>` | Install only skills in a given category |
| `cmux-claude install <skill>` | Install a single skill by name |
| `cmux-claude update` | Pull the latest changes from this repository |
| `cmux-claude list` | List all available skills, with version and category |
| `cmux-claude status` | Show installation status of every skill, global and project |
| `cmux-claude uninstall` | Remove all skills from the global installation |
| `cmux-claude uninstall <skill>` | Remove a single skill |
| `cmux-claude uninstall --project` | Remove all skills from the current project |

## Available skills

| Skill | Category | Description |
|---|---|---|
| `cmux` | core | Orientation, topology, and CLI handles |
| `cmux-workspace` | core | Non-disruptive workspace automation |
| `cmux-browser` | automation | Browser panel control with dev server detection |
| `cmux-claude-teams` | automation | Multi-agent coordination via Claude Teams, frontend-opinionated |
| `cmux-settings` | config | Reading and writing settings through the `cmux-settings` helper |
| `cmux-customization` | config | Custom actions, layouts, tab bar buttons, and dock controls |
| `cmux-keyboard-shortcuts` | config | Rebinding shortcuts and applying preset templates |
| `cmux-diagnostics` | utils | Health checks for the CLI, socket, and hooks |
| `cmux-markdown` | utils | Live-reloading markdown panels for plans and documentation |

## How it works

Each skill lives under `skills/<name>/`, containing a `SKILL.md` (the content Claude reads) and a `skill.json` (metadata: name, version, category, description).

Installing a skill creates a symlink from the install target (`~/.claude/skills/<name>` for global installs, `.claude/skills/<name>` for project installs) back to this repository. Because skills are symlinked rather than copied, running `cmux-claude update` — which simply pulls the latest commits — is enough to propagate changes to every installation immediately, with no separate reinstall step required.

## Versioning

Each skill carries its own `version` field in `skill.json`, allowing skills to evolve independently as the cmux CLI and Claude Code's capabilities change over time.
