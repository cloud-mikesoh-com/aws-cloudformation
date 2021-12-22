#!/bin/bash

set -ev

aws cloudformation update-stack --stack-name SecurityGroup-Deploy --template-body file://default-security-groups.yaml \
  --parameters ParameterKey=deployDate,ParameterValue=$(date -Isec) \
               ParameterKey=commitSha,ParameterValue=$(git rev-parse HEAD)
