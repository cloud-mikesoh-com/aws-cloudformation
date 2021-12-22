#!/bin/bash

set -ev

./deploy.bash update Galactica-SG-Deploy.yaml \
  ParameterKey=galacticaIp,ParameterValue=$(curl -s http://checkip.amazonaws.com/)
