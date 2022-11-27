#!/bin/bash

#Create a vpc
aws ec2 create-vpc --cidr-block '10.0.0.0/16' ` --tag-specification 'ResourceType=vpc,Tags=[{Key=Name,Value=vpc-activity1}]'
#VPC ID:- vpc-0f7cdb3417b574832

#create Subnet1-->web1

aws ec2 create-subnet --vpc-id 'vpc-0f7cdb3417b574832' --cidr-block '10.0.1.0/24' --availability-zone 'ap-south-1a' `
    --tag-specification 'ResourceType=subnet,Tags=[{Key=Name,Value=web1}]'

#Subnet id:- subnet-0af69915c27cbcf51

#create Subnet2-->web2

aws ec2 create-subnet --vpc-id 'vpc-0f7cdb3417b574832' --cidr-block '10.0.2.0/24' --availability-zone 'ap-south-1b' `
    --tag-specification 'ResourceType=subnet,Tags=[{Key=Name,Value=web2}]'
    
#Subnet id:- subnet-0002cb5ebefdeebf8


#create Subnet3-->app1

aws ec2 create-subnet --vpc-id 'vpc-0f7cdb3417b574832' --cidr-block '10.0.3.0/24' --availability-zone 'ap-south-1a' `
    --tag-specification 'ResourceType=subnet,Tags=[{Key=Name,Value=app1}]'
    
#Subnet id:- subnet-0d52d746d186ef181

#create Subnet4-->app2

aws ec2 create-subnet --vpc-id 'vpc-0f7cdb3417b574832' --cidr-block '10.0.4.0/24' --availability-zone 'ap-south-1b' `
    --tag-specification 'ResourceType=subnet,Tags=[{Key=Name,Value=app2}]'
    
#Subnet id:- subnet-001f0b5e41fd3c5aa

#create Subnet5-->db1

aws ec2 create-subnet --vpc-id 'vpc-0f7cdb3417b574832' --cidr-block '10.0.5.0/24' --availability-zone 'ap-south-1a' `
    --tag-specification 'ResourceType=subnet,Tags=[{Key=Name,Value=db1}]'
    
#Subnet id:- subnet-0f7f9bb5ce7294a00

#create Subnet6-->db2

aws ec2 create-subnet --vpc-id 'vpc-0f7cdb3417b574832' --cidr-block '10.0.6.0/24' --availability-zone 'ap-south-1b' `
    --tag-specification 'ResourceType=subnet,Tags=[{Key=Name,Value=db2}]'
    
#Subnet id:- subnet-052c3ed22f7115d52

#Create Internet Gateway
aws ec2 create-internet-gateway --tag-specification 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=activity1-igw}]'

#Internet Gateway ID:- igw-0c65c0df5f958665f

#Attach Internet Gateway to VPC
aws ec2 attach-internet-gateway --internet-gateway-id 'igw-0c65c0df5f958665f' --vpc-id 'vpc-0f7cdb3417b574832'

#Create Route Table 1 (Public)
aws ec2 create-route-table --vpc-id 'vpc-0f7cdb3417b574832' `
    --tag-specification 'ResourceType=route-table,Tags=[{Key=Name,Value=public1}]'

# Public Route Table Id:- rtb-079b13139c9e1fb3c

#Make Route Table Public 

aws ec2 create-route --route-table-id 'rtb-079b13139c9e1fb3c' --destination-cidr-block '0.0.0.0/0' `
     --gateway-id 'igw-0c65c0df5f958665f'

#Create Route Table 2 (Private)
aws ec2 create-route-table --vpc-id 'vpc-0f7cdb3417b574832' `
    --tag-specification 'ResourceType=route-table,Tags=[{Key=Name,Value=private1}]'

# Private Route Table Id:- rtb-08fa289e8ac00ee3a


#Attach Subnets:- web1 & web2 to Public Route Table

aws ec2 associate-route-table --route-table-id 'rtb-079b13139c9e1fb3c'  --subnet-id 'subnet-0002cb5ebefdeebf8'

 aws ec2 associate-route-table --route-table-id 'rtb-079b13139c9e1fb3c' --subnet-id 'subnet-0af69915c27cbcf51'
    
#Attach Subnets:- app1,app2,db1,db2 to Private Route Table

aws ec2 associate-route-table --route-table-id 'rtb-08fa289e8ac00ee3a' --subnet-id 'subnet-0d52d746d186ef181'

aws ec2 associate-route-table --route-table-id 'rtb-08fa289e8ac00ee3a' --subnet-id 'subnet-001f0b5e41fd3c5aa'

aws ec2 associate-route-table --route-table-id 'rtb-08fa289e8ac00ee3a' --subnet-id 'subnet-0f7f9bb5ce7294a00'

aws ec2 associate-route-table --route-table-id 'rtb-08fa289e8ac00ee3a' --subnet-id 'subnet-052c3ed22f7115d52'
