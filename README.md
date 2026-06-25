## Setup

Clone the repo and run setup to install the `cmux-claude` command globally:

```bash
git clone <repo-url> ~/Documents/devtools/personal/claude-cmux-skills
cd claude-cmux-skills
bash install.sh
```

## Commands

```bash
cmux-claude install                    # install all skills globally (~/.claude/skills)
cmux-claude install --project          # install to current project (.claude/skills)
cmux-claude install --category core    # install skills by category
cmux-claude install cmux-browser       # install a single skill

cmux-claude update                     # pull latest and refresh all installs
cmux-claude list                       # list available skills with versions
cmux-claude status                     # show where each skill is installed
cmux-claude uninstall                  # remove all from global
cmux-claude uninstall cmux-browser     # remove a single skill
cmux-claude uninstall --project        # remove from current project
```

## Skills

| Skill | Category | Description |
|---|---|---|
| `cmux` | core | Orientation, topology, CLI handles |
| `cmux-workspace` | core | Non-disruptive workspace automation |
| `cmux-browser` | automation | Browser panels with dev server detection |
| `cmux-claude-teams` | automation | Multi-agent coordination, frontend-opinionated |
| `cmux-settings` | config | Read/write settings via cmux-settings helper |
| `cmux-customization` | config | Actions, layouts, tab bar, dock controls |
| `cmux-keyboard-shortcuts` | config | Rebind shortcuts, preset templates |
| `cmux-diagnostics` | utils | Health checks for CLI, socket, hooks |
| `cmux-markdown` | utils | Live markdown panel for plans and docs |

## How it works

`cmux-claude install` creates symlinks from `~/.claude/skills/<name>` to the skill directories in this repo. `cmux-claude update` just runs `git pull` — symlinks pick up changes automatically with no reinstall needed.
