#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "Project directory: $SCRIPT_DIR"
echo "Checking Bundler..."

if ! command -v bundle >/dev/null 2>&1; then
  echo
  echo "Error: Bundler is not installed."
  echo "Install Ruby/Bundler first, then run this script again."
  read -r -p "Press Enter to close..."
  exit 1
fi

echo
echo "Installing dependencies..."
if ! bundle install; then
  echo
  echo "Error: bundle install failed."
  read -r -p "Press Enter to close..."
  exit 1
fi

echo
echo "Starting local preview..."
echo "Open: http://127.0.0.1:4000/"
echo

# Give Jekyll a moment to start, then open the preview page in the browser.
( sleep 3; open "http://127.0.0.1:4000/" ) &

bundle exec jekyll serve --host 127.0.0.1 --port 4000
