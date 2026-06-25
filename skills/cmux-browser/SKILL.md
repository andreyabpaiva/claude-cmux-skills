---
name: cmux-browser
description: Open and automate browser panels in cmux. Includes dev server detection before opening. Use for visual verification of UI changes or any web automation task.
allowed-tools: Bash
---

# cmux Browser

cmux embeds a WKWebView browser that you can open as a panel and drive with CLI commands.

## Before opening a panel — check for a dev server

Always verify a server is running before opening a browser panel:

```bash
# Check common dev server ports
for port in 3000 3001 5173 8080 8000; do
  if curl -s --max-time 1 "http://localhost:$port" > /dev/null 2>&1; then
    echo "Server found at localhost:$port"
    break
  fi
done
```

If no server is found, start one first (e.g. `pnpm dev`, `npm run dev`) in a split pane before opening the browser.

## Opening a browser panel

```bash
# Open next to the current terminal (default: uses CMUX_WORKSPACE_ID)
BROWSER_SURFACE=$(cmux new-split right --focus false --type browser --url "http://localhost:3000")
```

## Navigation

```bash
cmux browser --surface "$BROWSER_SURFACE" navigate "http://localhost:3000/new-page"
cmux browser --surface "$BROWSER_SURFACE" get url
```

## Waiting for page state

```bash
cmux browser --surface "$BROWSER_SURFACE" wait --load-state networkidle
cmux browser --surface "$BROWSER_SURFACE" wait --selector "#my-component"
cmux browser --surface "$BROWSER_SURFACE" wait --text "Welcome"
cmux browser --surface "$BROWSER_SURFACE" wait --url-contains "/dashboard"
```

## Interacting with the page

Always snapshot first to get element references, then act:

```bash
# Get interactive element references
cmux browser --surface "$BROWSER_SURFACE" snapshot --interactive

# Act using references from the snapshot
cmux browser --surface "$BROWSER_SURFACE" click "ref=button-submit"
cmux browser --surface "$BROWSER_SURFACE" fill "ref=input-email" "user@example.com"
cmux browser --surface "$BROWSER_SURFACE" press "ref=input-search" Enter
cmux browser --surface "$BROWSER_SURFACE" select "ref=dropdown-role" "admin"
```

## Extracting content

```bash
cmux browser --surface "$BROWSER_SURFACE" snapshot
cmux browser --surface "$BROWSER_SURFACE" get text
cmux browser --surface "$BROWSER_SURFACE" get html
```

## Stable agent loop

Navigate → verify URL → wait for state → snapshot → act → snapshot again to confirm.

## Limitations

WKWebView does not support: viewport emulation, offline mode, network interception, or trace recording.

## Related skills

- `cmux-workspace` — open browser panels without disrupting user focus
- `cmux-claude-teams` — use browser verification as part of a multi-agent QA step
