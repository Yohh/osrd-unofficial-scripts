#!/usr/bin/env bash

set -e

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Check if the user is in the osrd/front folder
if [[ "$(pwd)" != *"/osrd/front" ]]; then
	echo -e "❌ ${YELLOW}You need to be in the osrd/front folder to launch this script${NC}"
	exit 1
fi

ver=$(nix search nixpkgs playwright-driver | grep playwright-driver | grep -oP '\(\K.*?(?=\))')
jq --arg v "$ver" '.dependencies["@playwright/test"] = $v | .devDependencies["@playwright/test"] = $v' package.json > package.json.tmp && mv package.json.tmp package.json
npm install
newver=$(npx playwright --version)
echo -e "✅ ${GREEN}Playwright version updated to $newver${NC} in package.json and installed${NC}"
