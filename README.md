# BGCH box build with packer 

Creates an ubuntu 12.04 BGCH box for Virtual box and AMAZON ami 

# Run Example 

	packer build \ 
  	-var "IP_ADDRESS=<your eth0 address>" \ 
  	-var "aws_access=<your key>" -var "aws_key=<your key > "   \ 
  	-var "product=connectedboiler" \
  	-var "env=prod" \
  	-var "role=bosch-processor" \
  	-var "password=<That monkey 'stuff'>" \
  	-var "region=eu-west-1" \
  	-var "source_ami=ami-f0b11187" \
  	-var "subnet_id=subnet-cb8a7892" \
  	-var "vpc_id=vpc-9ff330fa" \
	  -var "instance_type=t2.micro" \
  	-var "root_volume_size=10" \
  	-var "data_volume_size=10" \
  	config_files/ubuntu64-server-12-04-5.json

at the end ww'll get the ami-id:

		....
		==> Builds finished. The artifacts of successful builds are:
		--> amazon-ebs: AMIs were created:
		
		eu-west-1: ami-f47acc83


The AMI  name is  allways ubuntu-12.04-5 and one instance can be started with :

	export REGION="eu-west-1"
	aws ec2 create-security-group --region=$REGION --group-name TstSecGroup --description "Test Security group for test instance " 

	{
    	"GroupId": "sg-ce71f1ab"
	}

	aws ec2 authorize-security-group-ingress  --region=$REGION --group-id sg-ce71f1ab --cidr "0.0.0.0/0" --protocol tcp --port 22
	aws ec2 run-instances --count=1 --key-name=<your key name > --image-id=ami-f47acc83 --instance-type=t2.micro --region=$REGION --security-group-ids sg-ce71f1ab

Now we can ssh the machine 

	ssh YourUserName@HostIpAddress

# Arguments 

## Build arguments 

* IP_ADDRESS : Just needed for virtualbox .......

* aws_access, aws_key : AWS credentials 

* region :  Aws region where to create the AMI 

* source_ami : source AMI to use. In eu-west-1 the ubuntu server 12.04.5 id is ami-f0b11187. Check ami id in other regions , or for ubuntu future versions. 
 
* vpc_id, subnet_id : vpc id/subnet_id to use while creating the AMI 

* instance_type : amazon instance type 

* root_volume_size"  : Size in Gb for the root volume

* data_volume_size"   : Size in Gb for the Data  volume

## Arguments for botostarpper  (https://github.com/ConnectedHomes/bgch-bootstrap/blob/master/docs/README-bootstrapper.md )

* product   :  ( connectedboiler , ....) 

* env :  Puppet environment

* role :  Puppet role (bosch-processor, .... )

# Requisites

## Packer 

Check install instructions at https://www.packer.io/docs/installation.html

# TODO

* Initialize new device for usage on first run  (Check Standard mount point )
