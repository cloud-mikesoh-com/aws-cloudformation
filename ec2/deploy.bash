#!/bin/bash

export SHA=$(git rev-parse HEAD)
export DEPLOY_DATE=$(date -Isec)
export EXPIRY=$(date -u -Isec -d "+15 minutes" | sed 's/+00:00$/Z/')

set -ev

export VERB='create-stack'
# export VERB='update-stack'

aws cloudformation ${VERB} \
  --template-body file://${1} \
  --stack-name ${1%%.*} \
  --parameters \
      ParameterKey=deployDate,ParameterValue=${DEPLOY_DATE} \
      ParameterKey=commitSha,ParameterValue=${SHA} \
      ${@:2}
