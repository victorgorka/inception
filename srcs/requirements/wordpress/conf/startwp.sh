if [ -d "/var/lib/mysql/${SQL_DB}" ]
then 
	echo "Database already exists"
else
    mkdir -p /var/www/wordpress
    # Wordpress CLI installation
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar 
    mv wp-cli.phar /usr/local/bin/wp
    rm wp-cli.phar

    # Wordpress installation
    cd /var/www/wordpress
    chown -R root:root /var/www/wordpress
    wp core download --locale=es_ES


    # Wordpress config using WP CLI
    # Reference --> https://developer.wordpress.org/cli/commands/core/install/
    wp config create --allow-root \
    --dbname=${SQL_DB} \
    --dbuser=${SQL_USER} \
    --dbpass=${SQL_PWRD} \
    --dbhost=mariadb:3306 --path='/var/www/wordpress'

    wp core install --allow-root \
    --url=${WP_URL} \
    --title=${WP_TITLE} \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PWRD} \
    --admin_email=${WP_ADMIN_EMAIL}

    # Creating a new user in wordpress
    # Reference --> https://developer.wordpress.org/cli/commands/user/create/
    wp user create ${WP_USER} ${WP_USER_EMAIL} \
    --role=author \
    --user_pass=${WP_USER_PWRD} \
    --display_name=${WP_DISPLAY_NAME} \
    --alow-root

fi

php-fpm81 -F