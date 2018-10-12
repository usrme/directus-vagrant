#!/usr/bin/env bash

# Directus installation path
DIR='/var/www/html'
PROJECT_NAME='directus'
PROJECT_DIR="$DIR/$PROJECT_NAME"
# Leave empty for latest release or use specific
# version number for release (e.g. '6.4.9')
PROJECT_VERS=''

mkdir "$PROJECT_DIR"

get_directus() {
  if [ ! -d "${PROJECT_DIR}/.git" ]; then
    DOWNLOAD_CMD="wget -O ${PROJECT_NAME}.tar.gz https://api.github.com/repos/${PROJECT_NAME}/${PROJECT_NAME}/tarball"

    if [ -n "$PROJECT_VERS" ]; then
      DOWNLOAD_CMD="${DOWNLOAD_CMD}/${PROJECT_VERS}"
    fi

    # Don't double quote as it needs to execute the command stored within
    $DOWNLOAD_CMD

    tar -xf "${PROJECT_NAME}.tar.gz" -C "$PROJECT_DIR" --strip 1

    pushd "$PROJECT_DIR"
      composer install
    popd
  fi
}

install_directus() {
  DIRECTUS_CLI="${PROJECT_DIR}/bin/directus"
  php "$DIRECTUS_CLI" install:config -h localhost -u root -p 123 -n directus
  php "$DIRECTUS_CLI" install:database
  php "$DIRECTUS_CLI" install:install -e admin@getdirectus.com -p password -t "Directus Demo"
}

apt-get update
composer self-update

get_directus
install_directus
