
if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi

if [ -d "/var/lib/mysql/${SQL_DB}" ]
then 
	echo "Database already exists"
else
    # init database
    /etc/init.d/mariadb setup
    rc-service mariadb start
    while ! mysqladmin ping --silent; do 
        sleep 1
    done
    #Create database and user for wordpress
    echo "CREATE DATABASE IF NOT EXISTS \`${SQL_DB}\`;" | mariadb	
    echo "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PWRD}';" | mariadb
    echo "GRANT ALL PRIVILEGES ON \`${SQL_DB}\`.* TO '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PWRD}';" | mariadb
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PWRD}';" | mariadb
    # echo "FLUSH PRIVILEGES;" | mariadb -u root

    mysqladmin -u root -p${SQL_ROOT_PWRD} shutdown

    #Import database
    #mariadb -uroot -p1234 ${SQL_DB} < /scripts/wordpress.sql
fi
exec mysqld_safe