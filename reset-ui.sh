#!/bin/sh

set -e

# you have to run this script while you are in the root directory of the project

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Check if the user is in the osrd-ui folder
if [[ "$(pwd)" != *"/osrd-ui" ]]; then
	echo -e "❌ ${YELLOW}You need to be in the osrd-ui folder to launch this script${NC}"
	exit 1
fi

echo -e "${GREEN}Removing node_modules from the root directory${NC}"

rm -rf node_modules
if [ -f package-lock.json ]; then
	echo -e "${YELLOW}Removing package-lock.json from the root directory${NC}"
fi

# create a list of all the osrd-ui sub-repos
sub_repos=$(ls -d ./ui-*)

# remove node_modules and dist from all the sub-repos

echo
echo -e "${GREEN}Removing node_modules and dist from:${NC}"
echo -e $sub_repos

# add storybook to the list of sub-repos

sub_repos="$sub_repos ./storybook"

for repo in $sub_repos; do
	echo
	echo -e "${GREEN}Removing node_modules and dist from $repo ${NC}"
	rm -rf $repo/node_modules
	if [ -f $repo/package-lock.json ]; then
		echo -e "${YELLOW}Removing package-lock.json from $repo ${NC}"
	fi
	rm -rf $repo/dist
done

# install packages in the root directory

echo
echo -e "${GREEN}Installing packages in the root directory${NC}"

npm install

# build the root directory

echo
echo -e "${GREEN}Building the root directory${NC}"

npm run build
