---
name: cmux
description: Core cmux orientation — understand your environment, manage topology, and use CLI handles. Use whenever you need to know where you are in cmux or control windows, workspaces, panes, and surfaces.
allowed-tools: Bash
---

# cmux Core

You are running inside cmux, a terminal multiplexer for macOS built on Ghostty. This is not a plain terminal — you have access to a structured environment you can actively use.

## Where you are

```bash
cmux identify --json
```

Returns your current position. The following environment variables are always available:

- `CMUX_SURFACE_ID` — the surface (terminal tab) you're running in
- `CMUX_WORKSPACE_ID` — the workspace (sidebar tab) containing your surface
- `CMUX_SOCKET_PATH` — the control socket for cmux CLI communication

## Hierarchy

```
Window
└── Workspace (sidebar tab)
    └── Pane (split region)
        └── Surface (terminal or browser panel)
```

## Common commands

```bash
# Inspect
cmux list-windows
cmux list-workspaces
cmux list-panes --workspace "${CMUX_WORKSPACE_ID}"
cmux list-surfaces --pane pane:N

# Create
cmux new-workspace --name "my-feature"
cmux new-split right --focus false    # returns a SURFACE_ID
cmux new-split down --focus false

# Focus
cmux select-workspace --workspace workspace:2
cmux focus-pane --pane pane:3

# Send to a surface
cmux send --surface surface:N "some command\n"
cmux send-key --surface surface:N Enter

# Read a surface
cmux read-screen --surface surface:N --lines 20
cmux read-screen --surface surface:N --scrollback

# Notifications
cmux notify --title "Done" --body "task complete" --workspace "${CMUX_WORKSPACE_ID}"
cmux trigger-flash --surface surface:N

# Events (wait for agent signals)
cmux events

# Settings
cmux docs settings
cmux settings path
cmux reload-config
```

## Handle format

Use short handles: `window:N`, `workspace:N`, `pane:N`, `surface:N`. Add `--id-format uuids` when UUID output is needed.

## Related skills

- `cmux-workspace` — scoping work to your current workspace without disrupting others
- `cmux-browser` — opening and automating browser panels
- `cmux-markdown` — displaying plans as live panels
- `cmux-claude-teams` — coordinating multiple Claude agents across surfaces
