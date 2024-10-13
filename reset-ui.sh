#!/bin/sh

# you have to run this script while you are in the root directory of the project

echo "Removing node_modules from the root directory"

rm -rf node_modules
rm package-lock.json

# create a list of all the osrd-ui sub-repos
sub_repos=$(ls -d ./ui-*)

# remove node_modules and dist from all the sub-repos

echo
echo "Removing node_modules and dist from:"
echo $sub_repos

for repo in $sub_repos; do
	echo
	echo "Removing node_modules and dist from $repo"
	rm -rf $repo/node_modules
	rm $repo/package-lock.json
	rm -rf $repo/dist
done

# install packages in the root directory

echo
echo "Installing packages in the root directory"

npm install

# build the root directory

echo
echo "Building the root directory"

npm run build
