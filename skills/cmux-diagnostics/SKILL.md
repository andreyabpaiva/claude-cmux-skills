---
name: cmux-diagnostics
description: Run health checks for cmux — CLI connectivity, socket, hooks, and agent sessions. Use when cmux commands are failing or agent integration seems broken.
allowed-tools: Bash
---

# cmux Diagnostics

When something is not working in cmux, run these checks in order. Stay read-only — never expose raw hook files, session JSON, prompt logs, tokens, or API keys.

## 1. CLI and socket

```bash
# Verify CLI is in PATH and responding
which cmux
cmux ping

# Check socket path
echo "$CMUX_SOCKET_PATH"
ls -la "$CMUX_SOCKET_PATH" 2>/dev/null || echo "socket not found"
```

**"cmux not found"** → installation or PATH issue. Check `~/.zshrc` or `~/.bashrc` for cmux in PATH.

## 2. Current context

```bash
cmux identify --json
```

If this fails, the socket is not reachable from the current surface. Restart cmux or check socket permissions.

## 3. Settings validation

```bash
cmux settings path
cmux settings validate
```

Check that `terminal.autoResumeAgentSessions` is set if you expect session restore.

## 4. Hook status

```bash
cmux hooks list
cmux hooks status --agent claude
```

If hooks are missing:

```bash
cmux hooks setup --agent claude
```

Prefer targeted fixes over reinstalling cmux entirely.

## 5. Notification system

```bash
cmux notify --title "Test" --body "diagnostics check" --workspace "${CMUX_WORKSPACE_ID}"
```

If the notification doesn't appear, check `notifications.dockBadge` and `notifications.sound` in settings.

## 6. After making changes

Rerun the checks above to confirm fixes took effect. `cmux reload-config` applies config changes without restarting the app.

## Related skills

- `cmux-settings` — inspect and fix settings
- `cmux` — verify topology and surface context
