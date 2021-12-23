# EC2

## SpotInstanceTest

[Spot Instances](https://aws) are great for testing cloud init scripts along with other tasks that can be interrupted.  Using this Cloudformation Template, I am able to deploy my normal `husker` EC2 instance.

Getting the [Metadata section](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-metadata.html) right was a bit of a challenge since Spot Instances are requested using `AWS::EC2::SpotFleet`.  It's not immediately intuiative that you can add the necessary [configuration metadata](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-init.html) within the SpotFleet Resource.

But thanks to this [ASCENDING blog post](https://blog.ascendingdc.com/spot-instance-2-minutes-termination/), I was able to figure it out.  Also a shoutout to [AWS Labs Cloudformation Templates](https://github.com/awslabs/aws-cloudformation-templates/blob/master/aws/solutions/OperatingSystems/ubuntu20.04LTS_cfn-hup.cfn.yaml) that shows how to install [CloudFormation helper scripts](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-helper-scripts-reference.html) for Ubuntu.
