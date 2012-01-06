require 'open-uri'

namespace :bootstrap do

  task :config do
    set :secret_keys, open('https://api.wordpress.org/secret-key/1.1/salt/').read

    db_config =  <<-EOF 
    // site url settings
    define('WP_HOME','http://real_domain.name');
    define('WP_SITEURL','http://sub.domain.net');

    // database settings
    define('DB_NAME', 'name of database');
    define('DB_USER', 'name of db user');
    define('DB_PASSWORD', 'password of db user');
    define('DB_HOST', 'localhost');
    define('DB_CHARSET', 'utf8');
    define('DB_COLLATE', '');
    $table_prefix  = 'wp_';

    // language settings
    define ('WPLANG', 'de_DE');

    // automatically generated keys
    #{secret_keys}

    if ( !defined('ABSPATH') )
    	define('ABSPATH', dirname(__FILE__) . '/');
    require_once(ABSPATH . 'wp-settings.php');
    EOF

    run "mkdir -p   #{shared_path}/config" 
    put db_config, "#{shared_path}/config/wp-config-template.php" 
  end 

end
