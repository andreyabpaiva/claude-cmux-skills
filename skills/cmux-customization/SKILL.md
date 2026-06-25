---
name: cmux-customization
description: Customize cmux — actions, workspace layouts, tab bar buttons, dock controls, and Ghostty terminal preferences. Use when setting up a project-specific layout or adding custom commands.
allowed-tools: Bash, Read
---

# cmux Customization

cmux is customized via `~/.config/cmux/cmux.json` (global) or `.cmux/cmux.json` (project-local). Project-local entries override global entries with the same ID or name.

## Before editing

Always inspect the current config first:

```bash
cmux settings path
cat ~/.config/cmux/cmux.json
```

Back up before bulk changes:

```bash
cp ~/.config/cmux/cmux.json ~/.config/cmux/cmux.json.bak.$(date +%Y%m%d%H%M%S)
```

## Custom actions (Command Palette)

Add to the `actions` array in `cmux.json`:

```json
{
  "actions": [
    {
      "id": "my-action",
      "name": "Start dev server",
      "command": "pnpm dev",
      "icon": "play.fill"
    }
  ]
}
```

After editing, reload:

```bash
cmux reload-config
```

## Workspace layouts

Define a layout that opens automatically for a project:

```json
{
  "commands": [
    {
      "id": "my-layout",
      "name": "Full-stack dev",
      "layout": {
        "splits": [
          { "direction": "right", "command": "pnpm dev" },
          { "direction": "down", "command": "pnpm test --watch" }
        ]
      }
    }
  ]
}
```

## Tab bar buttons

```json
{
  "ui": {
    "tabBarButtons": [
      { "id": "run-dev", "label": "Dev", "action": "my-action" }
    ]
  }
}
```

## Key principles

- Never store secrets in actions or commands — use environment variables or a secret manager
- Only edit `cmux.json`, never `settings.json` (legacy fallback)
- Always validate after editing: `cmux settings validate`
- Changes apply immediately via file watcher — no restart needed

## Related skills

- `cmux-settings` — read/write individual settings paths safely
- `cmux-keyboard-shortcuts` — rebind shortcuts
