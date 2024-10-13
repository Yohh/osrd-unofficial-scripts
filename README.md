## OSRD scripts:

_launch them while you're in osrd directory_

#### [setup-osrd](setup-osrd.sh)

this script gives you the ability to choose between two options or both:

- setup the docker configuration:
  - remove all the containers
  - remove all the images
  - remove all the volumes
  - setup a new configuration based on the docker-compose.yml file
    or the host configuration file if you give at least one argument and run the project on a linux system
- setup data:
  - restore a backup if you have a single `*.backup` file in the the parent directory
  - setup a light configuration based in the osrd scripts if you don't have a `*.backup` file

> [!CAUTION]
> You should not use this script automatically, its only purpose is to help you in a last
> resort situation or for first setup if you're not familiar with the project

## OSRD-UI scripts:

_launch them while you're in osrd-ui directory_

#### [reset-ui](reset-ui.sh)

this script will:

1. remove the `node_modules` and the `package-lock.json` in the `osrd-ui` directory if they exist
2. list all `ui-*` Subdirectories
3. remove the `node_modules`, `dist` directories and the `package-lock.json` file in each `ui-*` Subdirectory if they exist

_if no `package-lock.json` file exists in the subdirectories, you will have an error message, don't worry about it,
it's only in case you ran `npm install` in the subdirectories by mistake_

#### [create-tag](create-tag.sh)

this script will:

1. create a new annotated tag if:
   - you give it a tag name as an argument
   - the tag name follows the pattern `*.*.*` where `*` is a number
   - the tag name is not already used
2. push the tag to the remote repository

## about this repository

this repository is a collection of scripts that will help you to manage the [OSRD](https://github.com/OpenRailAssociation/osrd) project and the [OSRD-UI](https://github.com/OpenRailAssociation/osrd-ui) project.
</br>
**it's not part of the OSRD project itself**,
</br>
it's just a helper for the developers who are contributing to the project.

## License

This project is licensed under the GNU Lesser General Public License. See the [LICENSE](LICENSE) file for more details.
