#!/bin/bash -xe

export SHA=$(git rev-parse HEAD)
export SHA_SHORT=$(echo ${SHA} | cut -c 1-7)
export DEPLOY_DATE=$(date -Isec)
export EXPIRY=$(date -u -Isec -d "+15 minutes" | sed 's/+00:00$/Z/')
export VERB=''
export STACK_NAME=''
export UUID=$(cat /proc/sys/kernel/random/uuid)

if [[ $1 == 'create' ]]; then
  VERB='create-stack'
elif [[ $1 == 'update' ]]; then
  VERB='update-stack'
else
  echo "Usage: $0 <create|update> <stack-name> "
  exit 1
fi 

if [[ $2 == 't4gSpot.yaml' ]]; then
  STACK_NAME=${2%%.*}---${UUID}
else 
  STACK_NAME=${2%%.*}
fi

aws cloudformation ${VERB} \
  --template-body file://${2} \
  --stack-name ${STACK_NAME} \
  --parameters \
      ParameterKey=deployDate,ParameterValue=${DEPLOY_DATE} \
      ParameterKey=commitSha,ParameterValue=${SHA} \
#      ParameterKey=commitShaShort,ParameterValue=${SHA_SHORT} \
      ${@:3}


# I need to figure out a way to make this more modular:
# aws cloudformation create-stack --template-body file://SecurityGroup-Deploy.yaml --stack-name NewCaprica-SecurityGroup-Deploy --parameters ParameterKey=deployDate,ParameterValue=`date -Isec` ParameterKey=commitSha,ParameterValue=`git rev-parse HEAD` ParameterKey=Vpc,ParameterValue=NewCaprica
