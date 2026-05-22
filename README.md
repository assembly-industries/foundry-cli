# Foundry CLI

Command-line tool for setting up coding agents (Claude Code, Cursor) to work with [Assembly Foundry](https://assembly.industries).

## Install

```bash
curl -fsSL https://github.com/assembly-industries/foundry-cli/releases/latest/download/install.sh | bash
```

Or download directly:

```bash
curl -fsSL https://github.com/assembly-industries/foundry-cli/releases/latest/download/foundry \
  -o /usr/local/bin/foundry
chmod +x /usr/local/bin/foundry
```

## Usage

```bash
# Interactive setup in your project directory
foundry init

# Non-interactive
FOUNDRY_TOKEN=sat_xxx foundry init

# Verify configuration
foundry status
```

## What `foundry init` creates

| File | Purpose |
|------|---------|
| `.mcp.json` | MCP config for Claude Code |
| `.claude/skills/foundry/SKILL.md` | Claude Code skill |
| `.cursor/mcp.json` | MCP config for Cursor |
| `.cursor/rules/foundry-agent.mdc` | Cursor rule |
| `.foundry/config` | Local config (gitignored) |

## Development

Source of truth for the CLI lives in the main [assembly-api](https://github.com/assembly-industries/assembly-api) monorepo under `cli/`. Releases are published from this repository for public distribution.

To publish a new version:

```bash
cd cli/
gh release create v0.1.1 foundry install.sh \
  --repo assembly-industries/foundry-cli \
  --title "Foundry CLI v0.1.1"
```
