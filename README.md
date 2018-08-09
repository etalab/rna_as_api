[![Build Status](https://travis-ci.org/betagouv/rna_as_api.svg?branch=master)](https://travis-ci.org/betagouv/rna_as_api) [![Maintainability](https://api.codeclimate.com/v1/badges/1151a3c44866b36b78c8/maintainability)](https://codeclimate.com/github/betagouv/rna_as_api/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/1151a3c44866b36b78c8/test_coverage)](https://codeclimate.com/github/betagouv/rna_as_api/test_coverage)

# RNA as API

Dans le cadre du [Service Public de la Donnée](https://www.data.gouv.fr/fr/reference), certains jeux de données sont devenus publics. C'est le cas du Répertoire National des Associations.

Le projet RNA_as_api a pour vocation de mettre en valeur la donnée brute en la servant sous forme d'API.

Vous pouvez également consulter l'[API Sirene](https://github.com/betagouv/sirene_as_api).

## Fonctionnement

Cette API se connecte au dépot de fichiers sur [Data.gouv](https://www.data.gouv.fr/fr/datasets/repertoire-national-des-associations/) et télécharge automatiquement les derniers fichiers du RNA.

Les fichiers RNA vont par paire Waldec / Import :

- RNA_waldec : liste des associations disposant d’un n° RNA. Toutes les associations créées ou ayant déclaré un changement de situation depuis 2009 disposent d’un n° RNA.

- RNA_import : liste des associations créées depuis 1901 et qui n’ont pas effectué de déclaration de changement de situation depuis 2009.

## Installation manuelle en environnement dev

Pour une installation manuelle, vous aurez besoin de :

- postgresql en version supérieure a 9.5
- ruby en version 2.5.1
- git
- un runtime java pour solr (comme OpenJDK)

Clonez ce répertoire :

    git clone git@github.com:betagouv/rna_as_api.git && cd rna_as_api

Installez les dépendances :

    gem install bundler && bundle install

Preparez la base de données postgres :

    sudo -u postgres -i
    cd /path/vers/dossier/sirene_as_api
    psql -f postgresql_setup.txt

Lancez les migrations :

    bundle exec rails db:create
    bundle exec rails db:migrate

Si vous souhaitez utiliser les tests :

    RAILS_ENV=test bundle exec rails db:migrate

Vous pouvez maintenant lancer Solr :

    RAILS_ENV=production bundle exec rake sunspot:solr:start

Et importer les derniers fichiers RNA :

    bundle exec rake rna_as_api:import_last_monthly_stocks

C'est prêt ! vous pouvez lancer le serveur :

    bundle exec rails server

## Commandes utiles

Lancer le server Solr :

```bash
RAILS_ENV=MonEnvironnement bundle exec rake sunspot:solr:start
```

Pour se connecter au dépot de fichiers et importer automatiquement le dernier Waldec et/ou Import :

```bash
RAILS_ENV=MonEnvironnement bundle exec rake rna_as_api:import_last_monthly_stocks
```

Pour supprimer tout ou partie de la base de donnée, les commandes suivantes sont accessibles :

```bash
rake rna_as_api:delete_database:all              # Supprime tout
rake rna_as_api:delete_database:import           # Supprime les associations Import
rake rna_as_api:delete_database:waldec           # Supprime les associations Waldec
```

# Utilisation de l'API

## Recherche FullText

Il s'agit de l'endpoint principal. Vous pouvez faire des requêtes avec Curl :

    curl 'localhost:3000/v1/full_text/MA_RECHERCHE'

ou simplement en copiant l'adresse ´localhost:3000/v1/full_text/MA_RECHERCHE´
dans votre navigateur favori.

### Pagination des résultats

La page par défaut est la première. L'API renvoie par défaut 10 résultats par page.
Ces attributs peuvents être modifiés en passant en paramètres `page` et `per_page`.

### Format de réponse

L'API renvoie les réponses au format JSON avec les attributs suivant :

| Attribut      | Valeur                       |
|---------------|------------------------------|
| total_results | Total résultats              |
| total_pages   | Total de pages               |
| per_page      | Nombre de résultats par page |
| page          | Page actuelle                |
| associations  | Résultats                    |

## Recherche par ID d'association

    curl 'localhost:3000/v1/id/ID_ASSOCIATION'

Cette requête renvoie uniquement la fiche association correspondant à l'ID.

# Problèmes fréquents

Si l'API ne renvoie aucun résultat sur la recherche `fulltext` mais que la recherche `siret` fonctionne, vous avez sans doute besoin de réindexer. Tentez `RAILS_ENV=MonEnvironnement bundle exec rake sunspot:solr:reindex` (le server solr doit être actif).

En cas de problèmes avec le serveur solr, il peut être nécessaire de tuer les processus Solr en cours (obtenir le PID solr avec `ps aux | grep solr` puis les tuer avec la commande `kill MonPidSolr`). Relancer le serveur avec `RAILS_ENV=MonEnvironnement bundle exec rake sunspot:solr:start` suffit en général à corriger la situation.

Si Solr renvoie toujours des erreurs, c'est peut-être un problème causé par une allocation de mémoire trop importante. Commenter les lignes `memory` dans `config/sunspot.yml` et recommencer. Il peut être nécessaire de re-tuer les processus Solr.

Dans certains cas, le déploiement par Mina ne copie pas correctement les fichiers solr.
En cas d'erreur 404 - Solr not found, assurez vous que le fichier /solr/MonEnvironnement/core.properties est bien présent. Sinon, vous pouvez l'ajouter manuellement.

Si tout fonctionne sauf les suggestions, c'est probablement que le dictionnaire de suggestions n'a pas été construit. Executez la commande : `RAILS_ENV=MonEnvironnement bundle exec rake sirene_as_api:build_dictionary`

# License

Ce projet est sous [license MIT](https://fr.wikipedia.org/wiki/Licence_MIT)

