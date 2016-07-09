#!/usr/bin/env bash

# Directus installation path
DIR=/var/www/html
PROJECT_NAME='directus'
PROJECT_DIR="$DIR/$PROJECT_NAME"

# make directus directory
sudo mkdir $PROJECT_DIR

get_directus(){
  if [ ! -d "$DIR/.git" ]; then
    # can't git clone on a non-empty directory
    git clone https://github.com/directus/directus.git $PROJECT_DIR
    pushd $PROJECT_DIR
      composer install
    popd
  fi
}

install_directus() {
  DIRECTUS_CLI=$PROJECT_DIR/bin/directus
  php $DIRECTUS_CLI config -h=localhost -u=root -p=123 -n=directus
  php $DIRECTUS_CLI database
  php $DIRECTUS_CLI install -e=admin@admin.com -p=admin -t="Directus Demo"
}

get_directus
install_directus
