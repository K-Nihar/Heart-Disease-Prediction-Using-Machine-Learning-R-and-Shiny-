## Launch an EC2 instance

This guide describes how to use the "aws_EC2_template.yaml" template and "aws_EC2_template.json" parameter file 
to create an EC2 instance.

## Pre-requisites  :

1.	Instance with aws-cli installed.
2.	Credentialized user with 'AmazonS3FullAccess' and 'CloudFormationFullAccess' permissions.

## Amazon EC2 Creation

To create an EC2 instance, run the following command

```shell

 $ aws cloudformation --region <region-name> create-stack --stack-name <stack-name> --template-body file://aws_EC2_template.yaml --parameters file://aws_EC2_template.json

```

## Template Parameters in the Parameter File

*	**KeyName**						: The name of the Amazon EC2 key pair 
							  
*	**InstanceType**					: The instance type, such as t2.micro. The default type is m1.small.
 For the list of instance types,see [Allowed Instance type](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html?shortFooter=true)
						  
					Default value : m1.small
								  
*	**LatestAmiId**				: The unique ID of the Amazon Machine Image (AMI) that was assigned during registration. For example: ami-00bb6f60.
								  

																					
								  
*	**SecurityGroup**				: The Amazon EC2 security groups to assign to the Amazon EC2 instance. For example: sg-0492a2688af60610d.

					Input must be of the type : String
					
								  
*	**AvailabilityZone**: The Availability Zone where the specified instance is launched. For example: us-east-1b.
										
					
										
*	**Subnetid**	: the ID of the subnet that you want to launch the instance into. For example: subnet-0c44f9de2a3e16087

					

## Parameter to Identify creator of S3 bucket
										
*	**CreatedBy**						: Name of the user or the group who is creating the EC2 instance using this CLoudformation Template.