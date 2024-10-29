#!/bin/sh

set -e

# you have to run this script while you are in the root directory of the project

LIGHTCYAN='\033[0;96m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}Pulling Playwright image${NC}"

docker pull mcr.microsoft.com/playwright

echo
echo -e "${GREEN}Give broad access to the display to docker${NC}"

xhost +local:docker

echo
echo -e "${GREEN}Running Playwright container${NC}"
echo -e "${YELLOW}Don't forget to run${NC} ${LIGHTCYAN}cd front && yarn playwright install --with-deps${NC} ${YELLOW}inside the container${NC}"

docker run -it --rm \
	--name playwright \
	--network host \
	-e DISPLAY=$DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v $(pwd):/app \
	-w /app mcr.microsoft.com/playwright bash

echo
echo -e "${GREEN}Revoking broad access to the display${NC}"

xhost -local:docker

echo
echo -e "${GREEN}Playwright container stopped${NC}"

exit 0
