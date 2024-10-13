#!/bin/sh

set -e

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

# This script creates an annotated tag in the git repository

# Check if the user is in the osrd-ui folder
if [[ "$(pwd)" != *"/osrd-ui" ]]; then
	echo -e "❌ ${YELLOW}You need to be in the osrd-ui folder to launch this script${NC}"
	exit 1
fi

# Check if the tag name is provided

if [ -z "$1" ]; then
		echo -e "${GREEN}Please provide the tag name${NC}"
		exit 1
fi

# Check if the tag name is in the format 1.0.0

if ! echo "$1" | grep -q "^[0-9]\+\.[0-9]\+\.[0-9]\+$"; then
		echo -e "❌ ${YELLOW}Tag name should be in the format 1.0.0${NC}"
		exit 1
fi

# Fetch only tags

git fetch origin 'refs/tags/*:refs/tags/*'

# Check if the tag already exists

if git tag --list | grep -q "^$1$"; then 
		echo -e "❌ ${YELLOW}Tag $1 already exists${NC}"
		exit 1
fi

echo "${GREEN}Creating tag $1 ${NC}"

# Create the tag

git tag -a "$1" -m "v$1"

# check if the tag is created

if [ "$?" -eq 0 ]; then
		echo -e "✅ ${GREEN}Tag $1 created successfully${NC}"
else
		echo -e "❌ ${YELLOW}Failed to create tag $1 ${NC}"
		exit 1
fi

# Push the tag to the remote repository

echo -e "${GREEN}Pushing tag $1 to the remote repository${NC}"

git push origin "$1"
