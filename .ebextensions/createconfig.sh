#! /bin/bash

sed "s/<DATABASEURL>/$DBURL/" < config.php > config.php
sed "s/<DATABASENAME>/$DBNAME/" < config.php > config.php
sed "s/<DATABASEUSER>/$DBUSER/" < config.php > config.php
sed "s/<DATABASEPASSWORD>/$DBPASSWORD/" < config.php > config.php

mv config.php /