#!/bin/bash

set -e

# Met à jour les paquets et installe les dépendances nécessaires
apt-get update
apt-get install -y build-essential libpq-dev

# Affiche le chemin de pg_config pour vérification
which pg_config

# Installe les gems avec la configuration spécifiée pour pg
bundle config build.pg --with-pg-config=/opt/homebrew/bin/pg_config
bundle install
