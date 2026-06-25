---
name: cmux-markdown
description: Open a live markdown panel in cmux. Use proactively when starting any multi-step task — write a plan.md and display it alongside the terminal so the user can track progress in real time.
allowed-tools: Bash
---

# cmux Markdown Viewer

cmux can display markdown files as a rendered, live-reloading panel next to the terminal. Use this proactively — if you're about to do more than two steps, write a plan and show it.

## Proactive trigger

When starting a multi-step task (feature implementation, refactor, debugging session), do this before writing any code:

```bash
cat > plan.md << 'EOF'
# Task: <short description>

## Steps
- [ ] Step 1
- [ ] Step 2
- [ ] Step 3
EOF

cmux markdown open plan.md
```

Then update the file as you complete each step — the panel re-renders automatically:

```bash
sed -i '' 's/- \[ \] Step 1/- [x] Step 1/' plan.md
```

## Opening a panel

```bash
# Next to the current terminal (default)
cmux markdown open plan.md

# Absolute path
cmux markdown open /path/to/PLAN.md

# In a specific workspace
cmux markdown open plan.md --workspace workspace:2

# Splitting from a specific surface
cmux markdown open plan.md --surface "${CMUX_SURFACE_ID}"
```

## Live reload

The panel re-renders on any file change:
- Direct writes and appends
- Editor saves
- Atomic file replacement (write to temp, rename)

If the file is deleted, the panel shows "file unavailable". Close and reopen if it doesn't reconnect after the file returns.

## What renders

Headings, code blocks, inline code, tables, lists (nested), blockquotes, bold, italic, strikethrough, links, images, horizontal rules. Light and dark mode supported.

## Related skills

- `cmux-workspace` — open the panel without disrupting other panes
- `cmux-claude-teams` — use markdown to show the coordination plan during multi-agent tasks
