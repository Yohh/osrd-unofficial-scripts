#!/bin/sh

set -e

LIGHTCYAN='\033[0;96m'
GREEN='\033[0;32m'
BOLDGREEN='\033[1;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

ARGUMENTS=("postgres" "valkey" "core" "editoast" "gateway" "front" "rabbitmq" "osrd-images" "osrdyne")  

echo -e "${BOLDGREEN}This script gives you the choice between:${NC}
- Resetting the ${LIGHTCYAN}docker${NC} configuration, which will stop the containers, remove all containers and networks, then relaunch the containers.
( You can add options to the command, which will allow you to get access to the ${LIGHTCYAN}unmentioned containers${NC} from your host machine. )
- Restoring the ${LIGHTCYAN}backup${NC}, which will stop the containers, restore the backup, then relaunch the containers.
- Doing ${LIGHTCYAN}both${NC}, which will reset the docker configuration, then restore the backup.

⚠️  This script has to be located in osrd's parent folder.
⚠️  You need to be in the osrd folder to launch this script.
⚠️  If you want to restore the backup, you need to have the backup file in the osrd parent folder.
~~ otherwise, a light backup will be generated.
‼️  ${RED}You should not use this script automatically, its only purpose is to help you in a last resort situation or for first setup if you're not familiar with the project.${NC}"

echo

# Check arguments
if [ "$#" -gt 0 ]; then
	for arg in "$@"; do
		 if [[ ! " ${ARGUMENTS[@]} " =~ " ${arg} " ]]; then
			echo -e "❌ ${YELLOW}The argument ${arg} is not compatible with the script${NC}"
			exit 1
		 fi
	done
fi

# Check if the user is in the osrd folder
if [[ "$(pwd)" != *"/osrd" ]]; then
	echo -e "❌ ${YELLOW}You need to be in the osrd folder to launch this script${NC}"
	exit 1
fi

# let the user prompt if he wants to reset the docker configuration, restore the backup or both
read -p "Do you want to:
reset the docker configuration (d),
restore the backup (b),
full reset (f),
quit (q)" -n 1 -r
echo
echo

if [[ $REPLY =~ ^[Qq]$ ]]; then
	echo "⬅️  Exiting the script"
	exit 2
fi

# Reset the docker configuration
if [[ $REPLY =~ ^[Dd]$ ]] || [[ $REPLY =~ ^[Ff]$ ]]; then
	echo -e "${GREEN}shutting down the containers${NC}"
	docker compose down
	echo

	echo -e "${GREEN}removing all containers${NC}"
	docker system prune -af
	echo
	
	echo -e "${GREEN}removing osrd volumes${NC}"
	if [ $(docker volume ls --format '{{.Name}}' | grep osrd) ]; then
	  volumes=$(docker volume ls --format '{{.Name}}' | grep osrd)
	  for volume in $volumes; do
	    docker volume rm "$volume"
	  done
	elif [ "$volumes" == "" ]; then
	  echo -e "⚠️  ${YELLOW}No osrd volumes found${NC}"
	fi
	echo

	echo -e "${GREEN}checking the OS then launching the containers${NC}"
	echo
	# Check if linux and host argument is available
	if [ "$(uname)" == "Linux" ] && [ "$#" -gt 0 ]; then
		echo -e "${GREEN}🐧 Linux with host argument(s)${NC}"
		echo
		# Launch the containers with the options
		echo "🚀  ./scripts/osrd-compose.sh up --build $@ -d"
		echo
		./scripts/osrd-compose.sh up --build "$@" -d
	else
		echo -e "${GREEN}🐧 Linux, 🍎 MacOs or 🪟 Windows without host argument(s)${NC}"
		echo
		# Launch the containers without the options
		echo "🚀  docker compose up --build -d"
		echo
		docker compose up --build -d
	fi
fi

# Restore the backup
if [[ $REPLY =~ ^[Bb]$ ]] || [[ $REPLY =~ ^[Ff]$ ]]; then
	# Check if there is a backup file in the parent folder
	if [ ! -f ../*.backup ]; then
		echo -e "⚠️  ${YELLOW}No backup file found in the parent folder, a light backup will be generated${NC}"
		./scripts/load-railjson-infra.sh small_infra tests/data/infras/small_infra/infra.json
		./scripts/load-railjson-rolling-stock.sh tests/data/rolling_stocks/*.json
	else
		echo -e "${GREEN}restoring the backup${NC}"
		docker compose down
		docker compose up postgres -d
		./scripts/load-backup.sh ../*.backup
		./scripts/osrd-compose.sh up "$@" -d 
	fi
fi
