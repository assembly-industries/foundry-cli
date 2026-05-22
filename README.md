# Foundry CLI

Command-line tool for setting up coding agents (Claude Code, Cursor) to work with [Assembly Foundry](https://assembly.industries).

## Install

```bash
curl -fsSL https://github.com/assembly-industries/foundry-cli/releases/latest/download/install.sh | bash
```

## Usage

```bash
cd my-project
foundry init
foundry claude    # loads secrets + launches Claude Code with MCP
```

**Do not run bare `claude` unless direnv has loaded `.foundry/env`** — Claude Code requires `ASSEMBLY_FOUNDRY_TOKEN` in the environment to parse `.mcp.json`.

## Development

```bash
gh release upload v0.1.0 foundry install.sh \
  --repo assembly-industries/foundry-cli \
  --clobber
```
