---
name: cmux-claude-teams
description: Launch and coordinate multiple Claude agents in cmux using claude-teams. Frontend-opinionated — uses worktrees, type-check, and lint. Use when a task benefits from parallel agents or when /cmux-claude-teams is invoked.
allowed-tools: Bash, Read
---

# cmux Claude Teams

`cmux claude-teams` launches Claude Code with the experimental agent teams feature enabled via a tmux shim. Use this when a task is large enough to benefit from parallel agents working simultaneously.

## Launching

```bash
cmux claude-teams                    # fresh session
cmux claude-teams --continue         # resume previous session
cmux claude-teams --model sonnet     # specify model
cmux claude-teams --effort medium    # low | medium | high
```

All flags after `claude-teams` are forwarded to Claude Code.

## Environment

When running inside `cmux claude-teams`, these are set:
- `TMUX` — fake socket path encoding workspace and pane info
- `TMUX_PANE` — maps to current cmux pane
- `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` — enables the teams feature
- `CMUX_SOCKET_PATH` — cmux control socket for CLI commands

## Setting up a multi-agent workspace

Create a plan first, display it, then split into agent surfaces:

```bash
# 1. Write and display the plan
cat > plan.md << 'EOF'
# Feature: <name>

## Agent A — implementation
- [ ] Component
- [ ] Hook
- [ ] Types

## Agent B — tests + QA
- [ ] Unit tests
- [ ] Type-check
- [ ] Lint
EOF
cmux markdown open plan.md

# 2. Create agent surfaces
AGENT_A=$(cmux new-split right --focus false)
AGENT_B=$(cmux new-split down --focus false)

# 3. Start teams in each surface
cmux send --surface "$AGENT_A" "cmux claude-teams --effort medium"
cmux send-key --surface "$AGENT_A" Enter

cmux send --surface "$AGENT_B" "cmux claude-teams --effort medium"
cmux send-key --surface "$AGENT_B" Enter
```

## Frontend-opinionated split

For a frontend feature, divide by layer boundary:

- **Agent A** — presentation: view, component, provider, page route, i18n
- **Agent B** — data + quality: services, types, hooks, unit tests, type-check, lint

For smaller features, Agent A takes the full implementation and Agent B handles tests and verification.

## Worktrees for isolation

```bash
BRANCH=$(git branch --show-current)
REPO=$(git rev-parse --show-toplevel)
PARENT=$(dirname "$REPO")
NAME=$(basename "$REPO")

git worktree add "$PARENT/${NAME}-agent-a" -b "${BRANCH}-agent-a"
git worktree add "$PARENT/${NAME}-agent-b" -b "${BRANCH}-agent-b"

# Symlink node_modules to avoid reinstall
ln -s "$REPO/node_modules" "$PARENT/${NAME}-agent-a/node_modules"
ln -s "$REPO/node_modules" "$PARENT/${NAME}-agent-b/node_modules"
```

## Sending instructions to agents

```bash
cmux send --surface "$AGENT_A" "You are Agent A. Implement <scope> in $PARENT/${NAME}-agent-a.
When done: cmux notify --title 'Agent A done' --body 'implementation complete' --workspace \$CMUX_WORKSPACE_ID"
cmux send-key --surface "$AGENT_A" Enter
```

## Waiting for completion

```bash
cmux events   # blocks until a notify event arrives
```

Or poll:

```bash
cmux read-screen --surface "$AGENT_A" --lines 10
```

## QA step

After agents finish, run quality checks before merging:

```bash
QA_SURFACE=$(cmux new-split down --focus false)
cmux send --surface "$QA_SURFACE" "cd $REPO && pnpm type-check && pnpm lint"
cmux send-key --surface "$QA_SURFACE" Enter
```

## Visual verification

After QA passes, open the browser to verify the UI:

```bash
# Check dev server is running first
curl -s --max-time 1 http://localhost:3000 > /dev/null && \
  cmux new-split right --focus false --type browser --url "http://localhost:3000"
```

## Merging worktrees

```bash
git merge "${BRANCH}-agent-a" --no-ff -m "feat: merge agent-a"
git merge "${BRANCH}-agent-b" --no-ff -m "feat: merge agent-b"
git worktree remove "$PARENT/${NAME}-agent-a"
git worktree remove "$PARENT/${NAME}-agent-b"
git branch -d "${BRANCH}-agent-a" "${BRANCH}-agent-b"
```

## Related skills

- `cmux-markdown` — display the coordination plan as a live panel
- `cmux-browser` — verify the result visually after agents finish
- `cmux-workspace` — keep all splits within the current workspace
