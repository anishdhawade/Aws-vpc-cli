#Create VPC in Mumbai Region

aws ec2 create-vpc --cidr-block '172.16.0.0/16' ` --tag-specification 'ResourceType=vpc,Tags=[{Key=Name,Value=vpc-mumbai}]'

# Mumbai VPC ID:- vpc-0985517b0a02aa59c

#create Subnet1-->Mumbai-1

aws ec2 create-subnet --vpc-id 'vpc-0985517b0a02aa59c' --cidr-block '172.16.1.0/24' --availability-zone 'ap-south-1a' `
    --tag-specification 'ResourceType=subnet,Tags=[{Key=Name,Value=Mumbai-1}]'

# Mumbai Subnet id:- subnet-018c6e34eee9ae336

#Create VPC in Hyderabad Region

aws ec2 create-vpc --region 'ap-south-2' --cidr-block '10.0.0.0/16' `
     --tag-specification 'ResourceType=vpc,Tags=[{Key=Name,Value=vpc-hyderabad}]'

# Hyderabad VPC ID:-   vpc-00da1d9921e7c0230


 #create Subnet1-->Hyderabad-1

 aws ec2 create-subnet --vpc-id 'vpc-00da1d9921e7c0230' --region 'ap-south-2' --cidr-block '10.0.1.0/24' --availability-zone 'ap-south-2b' `
 --tag-specification 'ResourceType=subnet,Tags=[{Key=Name,Value=Hyderabad-1}]'


# Hyderabad Subnet id:- subnet-0409c47f54aa6c163


#Create VPC Peering Connection from Mumbai Region


aws ec2 create-vpc-peering-connection --vpc-id 'vpc-0985517b0a02aa59c'  `
    --peer-region 'ap-south-2' --peer-vpc-id 'vpc-00da1d9921e7c0230' `
    --tag-specification 'ResourceType=vpc-peering-connection,Tags=[{Key=Name,Value=Mumbai-Hyderabad}]'

# VPC Peering Connection ID:- pcx-004647beab1e355b3

# Accept VPC Peering Connection from Hyderabad Region
    aws ec2 accept-vpc-peering-connection --region 'ap-south-2' --vpc-peering-connection-id 'pcx-004647beab1e355b3'

#Edit Mumbai Route Tables to make connection between 2VPC's with Private IP's

aws ec2 create-route --route-table-id 'rtb-0addf04bbd3da072b' --destination-cidr-block '10.0.0.0/16' `
--vpc-peering-connection-id 'pcx-004647beab1e355b3'


#Edit Hyderabad Route Tables to make connection between 2VPC's with Private IP's

aws ec2 create-route --region 'ap-south-2' --route-table-id 'rtb-04f4c19469add94a0' --destination-cidr-block '172.16.0.0/16' `
--vpc-peering-connection-id 'pcx-004647beab1e355b3'

#Create internet gateway in Mumbai

aws ec2 create-internet-gateway --tag-specification 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=mumbai-peer-igw}]'

#Internet Gateway Id:- igw-0566195ec55572b16

#Attach internet gateway to vpc in mumbai

aws ec2 attach-internet-gateway --internet-gateway-id 'igw-0566195ec55572b16' --vpc-id 'vpc-0985517b0a02aa59c'

#Edit Mumbai Route Tables to make connection from Internet to VPC

aws ec2 create-route --route-table-id 'rtb-0addf04bbd3da072b' --destination-cidr-block '0.0.0.0/0' `
    --gateway-id 'igw-0566195ec55572b16'

#Create internet gateway in Hyderabad
aws ec2 create-internet-gateway --region 'ap-south-2' --tag-specification 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=mumbai-peer-igw}]'

#Hyderabad Internet Gateway ID:- igw-0a28f7fd9cb4c5208

#Attach internet gateway to vpc in hyderabad

aws ec2 attach-internet-gateway --internet-gateway-id 'igw-0a28f7fd9cb4c5208' --region 'ap-south-2' --vpc-id 'vpc-00da1d9921e7c0230'

#Edit Hyderabad Route Tables to make connection from Internet to VPC

aws ec2 create-route --route-table-id 'rtb-04f4c19469add94a0' --region 'ap-south-2' --destination-cidr-block '0.0.0.0/0' `
    --gateway-id 'igw-0a28f7fd9cb4c5208'