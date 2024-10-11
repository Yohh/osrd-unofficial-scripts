#!/bin/sh

set -e

# This script creates an annotated tag in the git repository

# Check if the tag name is provided

if [ -z "$1" ]; then
		echo "Please provide the tag name"
		exit 1
fi

# Check if the tag name is in the format 1.0.0

if ! echo "$1" | grep -q "^[0-9]\+\.[0-9]\+\.[0-9]\+$"; then
		echo "❌ Tag name should be in the format 1.0.0"
		exit 1
fi

# Fetch only tags

git fetch origin 'refs/tags/*:refs/tags/*'

# Check if the tag already exists

if git tag --list | grep -q "^$1$"; then 
		echo "❌ Tag $1 already exists"
		exit 1
fi

echo "Creating tag $1"

# Create the tag

git tag -a "$1" -m "v$1"

# check if the tag is created

if [ "$?" -eq 0 ]; then
		echo "✅ Tag $1 created successfully"
else
		echo "❌ Failed to create tag $1"
		exit 1
fi

# Push the tag to the remote repository

git push origin "$1"
