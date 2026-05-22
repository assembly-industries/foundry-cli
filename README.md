# Foundry CLI

Command-line tool for setting up coding agents (Claude Code, Cursor) to work with [Assembly Foundry](https://assembly.industries).

## Install

```bash
curl -fsSL https://github.com/assembly-industries/foundry-cli/releases/latest/download/install.sh | bash
```

## Usage

`foundry init` is **folder-specific** — run it in each project directory, similar to how Claude Code uses project-local config.

```bash
cd my-project
foundry init

# Token is embedded in .mcp.json — just launch the agent
claude
cursor .

# Change token later in this folder only
foundry init --update-token
foundry init --token sat_new...

# Check this folder's setup
foundry status
```

## What `foundry init` creates (in the current folder)

| File | Purpose |
|------|---------|
| `.mcp.json` | MCP config for Claude Code (token embedded, gitignored) |
| `.claude/skills/foundry/SKILL.md` | Claude Code skill |
| `.cursor/mcp.json` | MCP config for Cursor (token embedded, gitignored) |
| `.cursor/rules/foundry-agent.mdc` | Cursor rule |
| `.foundry/config` | This folder's token, URL, app slug (gitignored) |

## Development

Source of truth lives in the [assembly-api](https://github.com/assembly-industries/assembly-api) monorepo under `cli/`. Releases are published to the public [foundry-cli](https://github.com/assembly-industries/foundry-cli) repo.

```bash
cd cli/
# Re-publish dev build (same version, replaces release assets)
gh release upload v0.1.0 foundry install.sh \
  --repo assembly-industries/foundry-cli \
  --clobber
```
