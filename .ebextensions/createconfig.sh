#! /bin/bash

echo "about to modify config.php with the following env variables $DBURL, $DBNAME, $DBUSER, password"
sed "s/<DATABASEURL>/$DBURL/" < config.php > config.php
sed "s/<DATABASENAME>/$DBNAME/" < config.php > config.php
sed "s/<DATABASEUSER>/$DBUSER/" < config.php > config.php
sed "s/<DATABASEPASSWORD>/$DBPASSWORD/" < config.php > config.php
echo "modified config.php, moving config.php"
mv config.php /