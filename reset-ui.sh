#!/usr/bin/env bash

set -e

# you have to run this script while you are in the root directory of the project

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Check if the user is in the osrd-ui folder

case "$(pwd)" in
*/osrd/front) ;;
*) echo -e "❌ ${YELLOW}You need to be in the osrd/front/ folder to launch this script${NC}" && exit 1 ;;
esac

echo -e "${GREEN}Removing node_modules from the front directory${NC}"

rm -rf node_modules

# create a list of all the osrd-ui sub-repos
sub_repos=$(ls -d ./ui/ui-*)

# remove node_modules and dist from all the sub-repos

echo
echo -e "${GREEN}Removing node_modules and dist from:${NC}"
echo -e "$sub_repos"

for repo in $sub_repos; do
	rm -rf "$repo/dist"
done

# install packages in the root directory

echo
echo -e "${GREEN}Installing packages in the root directory${NC}"

npm install

# build the root directory

echo
echo -e "${GREEN}Building the root directory${NC}"

npm run build-ui
