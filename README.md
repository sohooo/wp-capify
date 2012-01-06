# WP-Capify

WP-Capify is a [Capistrano][1] setup tailor-made for [WordPress][2]. [Capistrano][1] is a developer tool for deploying web applications. It is typically installed on a workstation, and used to deploy code from your source code management (SCM) to one, or more servers.

This setup is inspired by [theme.fm][3] and supports multistage deployment to the environments `staging` and `production` from a development repository.

The modified `wp-config.php` only loads an existing `wp-config-<environment>.php` (gitignore'd), which means that no DB credentials are in the git repository. For local development, create a `wp-config-local.php`. For staging and production, just put the config in the `shared` directory (see below).


# Setup

* Development machine, with WP-Capify and your WordPress files in `public/`
* Staging server, e.g. `staging.example.com`
* Production server, e.g. `example.com`

## Development

    .
    |-- config
    |-- public
    |   |-- wp-config.php
    |   |-- wp-config-local.php (.gitignore'd)
    |   |-- wp-admin
    |   |-- ...
    |-- Capfile
    |-- README.md

## Staging/Production

    .
    |-- shared
    |   |-- wp-config-staging.php     (only @staging)
    |   |-- wp-config-production.php  (only @production)
    |   |-- uploads
    |   |   |-- blueprints.png
    |-- releases
    |-- current -> releases/<latest deploy>

## TODO

* update README: describe directories, symlinks (uploads, current)
* update README with tagging feature
* update README with install and bootstrap instructions
* bootstrap:wordpress: downloads wordpress to public/
* bootstrap:config: creates `wp-config-<local|staging|production>.php`


[1]: http://capify.org
[2]: http://wordpress.org/
[3]: http://theme.fm/2011/09/deploying-wordpress-with-capistrano-part-2-staging-servers-tagging-database-security-2213/ "Theme.fm"
