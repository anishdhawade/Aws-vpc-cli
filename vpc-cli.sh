#!/bin/bash

#Create a vpc
aws ec2 create-vpc --cidr-block '10.0.0.0/16' \ --tag-specification 'ResourceType=vpc,Tags=[{Key=Name,Value=vpc-activity1}]'
#VPC ID:- vpc-0f7cdb3417b574832

#create Subnet1-->web1

aws ec2 create-subnet --vpc-id 'vpc-0f7cdb3417b574832' --cidr-block '10.0.1.0/24' --availability-zone 'ap-south-1a' \
    --tag-specification 'ResourceType=subnet,Tags=[{Key=Name,Value=web1}]'
      