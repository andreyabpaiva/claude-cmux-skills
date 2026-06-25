---
name: cmux-workspace
description: Scope cmux automation to the current workspace without disrupting the user's other panes or focus. Use before creating splits, sending commands, or building layouts.
allowed-tools: Bash
---

# cmux Workspace

When automating cmux, always scope to the caller's workspace. The user may be viewing a completely different workspace — never steal focus or create things in unexpected places.

## Core rule

Default to `$CMUX_WORKSPACE_ID` and `$CMUX_SURFACE_ID` for every command that accepts a workspace or surface flag. Never call focus-changing commands (`select-workspace`, `focus-pane`, `focus-panel`) unless the user explicitly asks.

## Creating splits non-disruptively

`new-split` requires a direction and supports `--focus false`:

```bash
# Open a split to the right without stealing focus
MY_SURFACE=$(cmux new-split right --focus false)

# Open a split below without stealing focus
OTHER_SURFACE=$(cmux new-split down --focus false)
```

Always capture the returned surface ID — you'll need it to send commands and read output.

## Sending work to a surface

```bash
cmux send --surface "$MY_SURFACE" "pnpm dev\n"
cmux send-key --surface "$MY_SURFACE" Enter
```

## Reading output from a surface

```bash
cmux read-screen --surface "$MY_SURFACE" --lines 30
cmux read-screen --surface "$MY_SURFACE" --scrollback
```

## Helper pane pattern

Before creating a new split, check whether a helper pane already exists to the right:

```bash
cmux list-panes --workspace "${CMUX_WORKSPACE_ID}"
```

If a right-side pane already exists, add a surface to it instead of creating another split.

## Sending back to your own surface

```bash
cmux send --surface "${CMUX_SURFACE_ID}" "echo done\n"
```

## Key principle

Build layouts additively in one command. Avoid create → move → focus chains — they disrupt the user and are error-prone.
