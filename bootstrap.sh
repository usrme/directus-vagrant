#!/usr/bin/env bash

# Directus installation path
DIR=/var/www/directus/public


get_directus(){
  if [ ! -d "$DIR/.git" ]; then
    # can't git clone on a non-empty directory
    rm -rf $DIR/.gitkeep
    git clone https://github.com/RNGR/Directus.git $DIR
    pushd $DIR/api
      composer install
    popd
  fi
}

install_directus() {
  DIRECTUS_CLI=$DIR/bin/directus
  php $DIRECTUS_CLI config -h=localhost -u=root -p=root -n=directus
  php $DIRECTUS_CLI database
  php $DIRECTUS_CLI install -e=admin@admin.com -p=admin -t="Directus Demo"
}

get_directus
install_directus
