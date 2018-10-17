#!/usr/bin/env bash

# Directus installation path
DIR='/var/www/html'
PROJECT_NAME='directus'
ORG_NAME='directus'
REPO_NAME='directus'
PROJECT_DIR="$DIR/$PROJECT_NAME"
PROJECT_VERS="$1"

mkdir "$PROJECT_DIR"

get_directus() {
  DOWNLOAD_CMD="wget -O ${PROJECT_NAME}.tar.gz https://api.github.com/repos/${ORG_NAME}/${REPO_NAME}/tarball"

  if [ -n "$1" ]; then
    DOWNLOAD_CMD="${DOWNLOAD_CMD}/$1"
  else
    LATEST_VERS=$(curl -s https://api.github.com/repos/${ORG_NAME}/${REPO_NAME}/releases/latest |
      grep 'tag_name' |
      cut -d '"' -f4
      )
    DOWNLOAD_CMD="${DOWNLOAD_CMD}/${LATEST_VERS}"
  fi

  # Don't double quote as it needs to execute the command stored within
  $DOWNLOAD_CMD

  tar -xf "${PROJECT_NAME}.tar.gz" -C "$PROJECT_DIR" --strip 1

  pushd "$PROJECT_DIR"
    composer install
  popd
}

install_directus() {
  DIRECTUS_CLI="${PROJECT_DIR}/bin/directus"
  php $DIRECTUS_CLI install:config -h localhost -u root -p 123 -n directus
  php $DIRECTUS_CLI install:database
  php $DIRECTUS_CLI install:install -e admin@getdirectus.com -p password -t "Directus Demo"
}

apt-get update
composer self-update

get_directus "$PROJECT_VERS"
install_directus
