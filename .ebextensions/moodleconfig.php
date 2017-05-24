Resources:
  AWSEBAutoScalingGroup:
    Metadata:
      AWS::CloudFormation::Authentication:
        S3Auth:
          type: "s3"
          buckets: ["moodle-elasticbeanstalk-deployables-us-east-1"]
          roleName:
            "Fn::GetOptionSetting":
              Namespace: "aws:autoscaling:launchconfiguration"
              OptionName: "IamInstanceProfile"
              DefaultValue: "aws-elasticbeanstalk-ec2-role"
commands:
  01_mount:
    command: "/tmp/dbconfig.sh"

files: 
  /tmp/config/config.php:
    mode: "000777"
    owner: ec2-user
    group: ec2-user
    authentication: "S3Auth"
    source: https://s3.amazonaws.com/moodle-elasticbeanstalk-deployables-us-east-1/tenant1/config/tenant1/config.php

files:
  /tmp/config/dbconfig.sh:
    mode: "000755"
    owner: root
    group: root
    content: |
      #!/usr/bin/env bash
      # Using similar syntax as the appdeploy pre hooks that is managed by AWS
      echo "about to modify config.php with the following env variables $DBURL, $DBNAME, $DBUSER, password"
      sed "s/<DATABASEURL>/$DBURL/" < config.php > config.php
      sed "s/<DATABASENAME>/$DBNAME/" < config.php > config.php
      sed "s/<DATABASEUSER>/$DBUSER/" < config.php > config.php
      sed "s/<DATABASEPASSWORD>/$DBPASSWORD/" < config.php > config.php
      echo "modified config.php, moving config.php"
      mv config.php /