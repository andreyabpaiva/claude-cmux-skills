---
name: cmux-keyboard-shortcuts
description: Rebind cmux keyboard shortcuts. Use when the user wants to change key bindings, apply a preset template (tmux, vim, agent triage), or audit current shortcuts.
allowed-tools: Bash
---

# cmux Keyboard Shortcuts

Shortcuts are stored in `shortcuts.bindings.<actionId>` inside `~/.config/cmux/cmux.json`.

## Reading current bindings

```bash
cmux settings get shortcuts.bindings
cmux settings validate
```

## Setting a shortcut

```bash
# Single stroke
cmux settings set shortcuts.bindings.newSurface "cmd+t"

# Chord (tmux-style)
cmux settings set shortcuts.bindings.newSurface '["ctrl+b","c"]'

# Unbind
cmux settings set shortcuts.bindings.sendFeedback null
```

Changes apply immediately — no restart needed.

## Shortcut model

- Single stroke: `"cmd+b"`
- Chord: `["ctrl+b","c"]` — first stroke needs a modifier; second can be bare
- Unbind: `null`
- `selectSurfaceByNumber` and `selectWorkspaceByNumber` use digits 1–9 (`cmd+1` covers the full family)

## Preset templates

### Tmux prefix
```bash
cmux settings set shortcuts.bindings.newSurface '["ctrl+b","c"]'
cmux settings set shortcuts.bindings.closeTab '["ctrl+b","x"]'
cmux settings set shortcuts.bindings.splitRight '["ctrl+b","v"]'
cmux settings set shortcuts.bindings.splitDown '["ctrl+b","s"]'
cmux settings set shortcuts.bindings.focusLeft '["ctrl+b","h"]'
cmux settings set shortcuts.bindings.focusDown '["ctrl+b","j"]'
cmux settings set shortcuts.bindings.focusUp '["ctrl+b","k"]'
cmux settings set shortcuts.bindings.focusRight '["ctrl+b","l"]'
cmux settings set shortcuts.bindings.toggleSplitZoom '["ctrl+b","z"]'
```

### Vim pane navigation
```bash
cmux settings set shortcuts.bindings.focusLeft "cmd+opt+h"
cmux settings set shortcuts.bindings.focusDown "cmd+opt+j"
cmux settings set shortcuts.bindings.focusUp "cmd+opt+k"
cmux settings set shortcuts.bindings.focusRight "cmd+opt+l"
cmux settings set shortcuts.bindings.splitRight "cmd+opt+v"
cmux settings set shortcuts.bindings.splitDown "cmd+opt+s"
cmux settings set shortcuts.bindings.toggleSplitZoom "cmd+opt+z"
```

### Agent triage
```bash
cmux settings set shortcuts.bindings.showNotifications "cmd+u"
cmux settings set shortcuts.bindings.jumpToUnread "cmd+j"
cmux settings set shortcuts.bindings.markOldestUnreadAndJumpNext "cmd+shift+j"
cmux settings set shortcuts.bindings.toggleUnread "cmd+opt+u"
cmux settings set shortcuts.bindings.triggerFlash "cmd+shift+h"
```

## Before applying a template

Snapshot the current values of every action you'll change so you can revert:

```bash
cmux settings get shortcuts.bindings.focusLeft 2>/dev/null || echo "<absent>"
```

Use `unset` to revert actions that were absent before; use `set` to restore previous custom values.

## Rules

- Do not invent action IDs — only use recognized ones from `cmux settings list-supported`
- `cmd+[` and `cmd+]` collide with browser Back/Forward — warn before assigning them
- `showHideAllWindows` requires Settings > Global Hotkey to be enabled separately
