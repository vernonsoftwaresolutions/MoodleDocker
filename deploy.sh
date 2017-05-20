#! /bin/bash
EB_BUCKET=$1
VERSION=$2
echo $EB_BUCKET
echo $VERSION

#docker file
DOCKERRUN_FILE=Dockerrun.aws.json
echo $DOCKERRUN_FILE
sed "s/<TAG>/$VERSION/" < Dockerrun.aws.json.template > $DOCKERRUN_FILE
cat $DOCKERRUN_FILE

echo "zipping deployables"
DEPLOYMENT="moodledeployment$VERSION.zip"
zip -r $DEPLOYMENT $DOCKERRUN_FILE .ebextensions
echo "created zip $DEPLOYMENT"
aws s3 cp $DEPLOYMENT s3://$EB_BUCKET/moodle/
aws s3 cp config.php s3://$EB_BUCKET/config/
