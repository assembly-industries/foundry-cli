#!/usr/bin/env bash
set -euo pipefail

# ─── Foundry CLI Installer ────────────────────────────────────────────────────
#
# Usage:
#   curl -fsSL https://github.com/assembly-industries/foundry-cli/releases/latest/download/install.sh | bash
#
# Or with a specific install directory:
#   curl -fsSL https://github.com/assembly-industries/foundry-cli/releases/latest/download/install.sh | INSTALL_DIR=~/.local/bin bash

INSTALL_DIR="${INSTALL_DIR:-/usr/local/bin}"
BINARY_NAME="foundry"

GITHUB_ORG="assembly-industries"
GITHUB_REPO="foundry-cli"
RELEASES_BASE="https://github.com/$GITHUB_ORG/$GITHUB_REPO/releases"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

info()    { echo -e "${BLUE}▸${RESET} $*"; }
success() { echo -e "${GREEN}✔${RESET} $*"; }
warn()    { echo -e "${YELLOW}⚠${RESET} $*"; }
error()   { echo -e "${RED}✖${RESET} $*" >&2; }

echo -e ""
echo -e "${BOLD}Assembly Foundry CLI Installer${RESET}"
echo -e "${DIM}──────────────────────────────${RESET}"
echo -e ""

if [ -z "${BASH_VERSION:-}" ]; then
  error "This installer requires bash. Run with: bash <(curl -fsSL ...)"
  exit 1
fi

if ! command -v curl &>/dev/null && ! command -v wget &>/dev/null; then
  error "curl or wget is required but not found."
  exit 1
fi

download() {
  local url="$1" dest="$2"
  if command -v curl &>/dev/null; then
    curl -fsSL "$url" -o "$dest"
  else
    wget -qO "$dest" "$url"
  fi
}

# Resolve the version to download
FOUNDRY_VERSION="${FOUNDRY_VERSION:-latest}"

if [ "$FOUNDRY_VERSION" = "latest" ]; then
  info "Resolving latest release..."
  if command -v curl &>/dev/null; then
    DOWNLOAD_URL="$RELEASES_BASE/latest/download/foundry"
  else
    DOWNLOAD_URL="$RELEASES_BASE/latest/download/foundry"
  fi
else
  DOWNLOAD_URL="$RELEASES_BASE/download/v${FOUNDRY_VERSION}/foundry"
fi

info "Downloading foundry CLI..."
TMP_FILE=$(mktemp)
trap 'rm -f "$TMP_FILE"' EXIT

if ! download "$DOWNLOAD_URL" "$TMP_FILE" 2>/dev/null; then
  echo -e ""
  error "Download failed from: $DOWNLOAD_URL"
  echo -e ""
  echo -e "  Possible causes:"
  echo -e "  • No release has been published yet"
  echo -e "  • The repository is private (use a GitHub token)"
  echo -e "  • The version ${DIM}$FOUNDRY_VERSION${RESET} doesn't exist"
  echo -e ""
  echo -e "  To publish a release:"
  echo -e "    ${BOLD}gh release create v0.1.1 foundry install.sh --repo assembly-industries/foundry-cli --title 'Foundry CLI v0.1.1'${RESET}"
  echo -e ""
  echo -e "  To install manually:"
  echo -e "    ${BOLD}cp cli/foundry /usr/local/bin/foundry && chmod +x /usr/local/bin/foundry${RESET}"
  exit 1
fi

chmod +x "$TMP_FILE"

# Validate it's actually a shell script (not an HTML error page)
if ! head -1 "$TMP_FILE" | grep -q '^#!/'; then
  error "Downloaded file is not a valid script. The release asset may be missing."
  echo -e "  Check: ${DIM}$DOWNLOAD_URL${RESET}"
  exit 1
fi

# Install to target directory
if [ -w "$INSTALL_DIR" ]; then
  mv "$TMP_FILE" "$INSTALL_DIR/$BINARY_NAME"
else
  info "Need sudo to write to $INSTALL_DIR"
  sudo mv "$TMP_FILE" "$INSTALL_DIR/$BINARY_NAME"
  sudo chmod +x "$INSTALL_DIR/$BINARY_NAME"
fi

success "Installed to ${DIM}$INSTALL_DIR/$BINARY_NAME${RESET}"

if command -v "$BINARY_NAME" &>/dev/null; then
  echo -e ""
  success "foundry is ready: $("$BINARY_NAME" version)"
else
  echo -e ""
  warn "${BOLD}$INSTALL_DIR${RESET} is not in your PATH."
  echo -e "  Add it:  ${BOLD}export PATH=\"$INSTALL_DIR:\$PATH\"${RESET}"
fi

echo -e ""
echo -e "Get started:"
echo -e "  ${BOLD}cd your-project${RESET}"
echo -e "  ${BOLD}foundry init${RESET}"
echo -e ""
