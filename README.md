# Foundry CLI

Command-line tool for setting up coding agents (Claude Code, Cursor) to work with [Assembly Foundry](https://assembly.industries).

## Install

```bash
curl -fsSL https://github.com/assembly-industries/foundry-cli/releases/latest/download/install.sh | bash
```

## Usage

`foundry init` is **folder-specific** — run it in each project directory.

Secrets live in `.foundry/env` (gitignored). MCP configs use env vars. **direnv** auto-loads secrets when you `cd` into the folder. `foundry init` runs `direnv allow` for you.

```bash
cd my-project
foundry init

# With direnv (recommended)
cd my-project && claude

# Without direnv
source .foundry/env && claude
```

### One-time direnv setup

```bash
brew install direnv
echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
source ~/.zshrc
```

## What `foundry init` creates

| File | Purpose |
|------|---------|
| `.mcp.json` | Claude Code MCP config (env var references, no secrets) |
| `.cursor/mcp.json` | Cursor MCP config (env var references, no secrets) |
| `.envrc` | direnv loader for `.foundry/env` |
| `.foundry/env` | Folder secrets — gitignored |
| `.foundry/config` | Folder settings — gitignored |

## Development

```bash
cd cli/
gh release upload v0.1.0 foundry install.sh \
  --repo assembly-industries/foundry-cli \
  --clobber
```
