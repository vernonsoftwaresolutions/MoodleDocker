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

files: 
  "/tmp/config/config.php":
    mode: "000777"
    owner: ec2-user
    group: ec2-user
    authentication: "S3Auth"
    source: https://s3.amazonaws.com/moodle-elasticbeanstalk-deployables-us-east-1/tenant1/config/tenant1/config.php
  