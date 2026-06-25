---
name: cmux-settings
description: Read and write cmux settings at ~/.config/cmux/cmux.json. Use when changing appearance, notifications, automation, browser preferences, or any app setting.
allowed-tools: Bash
---

# cmux Settings

Settings live at `~/.config/cmux/cmux.json` (JSONC format). Changes apply immediately via file watcher — never tell the user to restart cmux.

## Reading settings

```bash
cmux settings path                          # config file location
cmux settings get app.appearance            # get a single value
cmux settings dump                          # full file with comments
cmux settings dump --no-comments            # parsed JSON
cmux settings list-supported               # all recognized paths
cmux settings validate                     # check for unknown keys
```

## Writing settings

```bash
cmux settings set app.appearance dark
cmux settings set notifications.dockBadge true
cmux settings set browser.defaultSearchEngine '"DuckDuckGo"'
cmux settings unset app.appIcon             # revert to default
```

## Key settings

**Appearance**
- `app.appearance` — `system` | `light` | `dark`
- `app.menuBarOnly` — hide dock icon
- `app.minimalMode` — hide tab bar

**Sidebar**
- `sidebarAppearance.matchTerminalBackground` — blend sidebar with terminal theme
- `sidebarAppearance.tintColor` — hex color e.g. `#1a1a2e`

**Notifications**
- `notifications.dockBadge` — show unread badge on dock icon
- `notifications.sound` — enable notification sounds

**Automation**
- `automation.socketControlMode` — enable socket control for CLI
- `terminal.autoResumeAgentSessions` — resume agent sessions on restart

**Browser**
- `browser.defaultSearchEngine` — search engine name
- `browser.theme` — `system` | `light` | `dark`

**Shortcuts**
- `shortcuts.bindings.<actionId>` — single stroke `"cmd+b"` or chord `["ctrl+b","c"]`

## Rules

- Only edit `cmux.json`. Never edit `settings.json` unless explicitly asked (it's legacy).
- Color values must be `#RRGGBB`. Opacities are `0.0` to `1.0`.
- Never blindly overwrite non-settings sections (`actions`, `ui`, `commands`, `vault`).
- Run `cmux settings validate` after bulk edits.

## Related skills

- `cmux-customization` — for actions, layouts, and UI elements
- `cmux-keyboard-shortcuts` — for shortcut bindings specifically
