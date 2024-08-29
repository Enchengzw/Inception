#!/bin/bash

# Start MariaDB server in the background
mysqld_safe &

# Wait for MariaDB to start up
echo "Waiting for MariaDB to start..."
for i in {1..30}; do
    if mysqladmin ping -h localhost --silent; then
        echo "MariaDB is up and running."
        break
    else
        echo "MariaDB is not yet ready. Waiting..."
        sleep 2
    fi
done

# Check if MariaDB started successfully
if ! mysqladmin ping -h localhost --silent; then
    echo "MariaDB failed to start."
    exit 1
fi

# Run MySQL commands with root password
echo "Creating database and user..."

mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

echo "Setup completed successfully."

mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
mysqld_safe