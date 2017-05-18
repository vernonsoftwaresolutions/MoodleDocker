#! /bin/bash
EB_BUCKET=$1
VERSION=$2
echo $EB_BUCKET
echo $VERSION

#docker file
DOCKERRUN_FILE=$VERSION-Dockerrun.aws.json
echo $DOCKERRUN_FILE
sed "s/<TAG>/$SHA1/" < Dockerrun.aws.json.template > $DOCKERRUN_FILE
aws s3 cp $DOCKERRUN_FILE s3://$EB_BUCKET/$DOCKERRUN_FILE
