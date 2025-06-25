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

_launch them while you're in osrd/front directory_

#### [reset-ui](reset-ui.sh)

this script will setup a fresh installation of the `osrd-ui` project by:

1. remove the `node_modules` in the `osrd/front` directory if they exist
2. list all `/front/ui-*` Subdirectories
3. remove the `node_modules`, `dist` directories each `ui-*` Subdirectory if they exist
4. run `npm install` in the `/front` directory
5. run `npm run build-ui` in the `/front` directory

## about this repository

this repository is a collection of scripts that will help you to manage the [OSRD](https://github.com/OpenRailAssociation/osrd) project and the [OSRD-UI](https://github.com/OpenRailAssociation/osrd-ui) project.
</br>
**it's not part of the OSRD project itself**,
</br>
it's just a helper for the developers who are contributing to the project.

## License

This project is licensed under the GNU Lesser General Public License. See the [LICENSE](LICENSE) file for more details.
