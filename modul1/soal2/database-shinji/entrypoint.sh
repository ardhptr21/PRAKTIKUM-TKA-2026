#!/bin/bash
set -e

chown -R mysql:mysql /var/data/db /var/run/mysqld

if [ ! -d "/var/data/db/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/data/db
    mysqld --user=mysql --datadir=/var/data/db --skip-networking &
    pid="$!"

    until mysqladmin ping --silent; do
        sleep 1
    done

    if [ -f "/init.sql" ]; then
        mysql -uroot < /init.sql
    fi

    mysqladmin shutdown
fi

echo "Starting MariaDB server..."
exec "$@" --user=mysql --datadir=/var/data/db --bind-address=0.0.0.0 --console