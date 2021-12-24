#!/bin/bash -xe

export SHA=$(git rev-parse HEAD)
export DEPLOY_DATE=$(date -Isec)
export EXPIRY=$(date -u -Isec -d "+15 minutes" | sed 's/+00:00$/Z/')
export VERB=''

if [[ $1 == 'create' ]]; then
  VERB='create-stack'
elif [[ $1 == 'update' ]]; then
  VERB='update-stack'
else
  echo "Usage: $0 <create|update> <stack-name> "
  exit 1
fi 

aws cloudformation ${VERB} \
  --template-body file://${2} \
  --stack-name ${2%%.*} \
  --parameters \
      ParameterKey=deployDate,ParameterValue=${DEPLOY_DATE} \
      ParameterKey=commitSha,ParameterValue=${SHA} \
      ${@:3}
