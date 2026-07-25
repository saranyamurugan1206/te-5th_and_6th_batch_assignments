PROJECT-1: 2-TIER WEB APPLICATION INFRASTRUCTURE ON AWS

Project Overview :This project provisions a complete two-tier AWS infrastructure using Terraform. It creates a Virtual Private Cloud (VPC) with a public subnet for a web server and a private subnet for a database server. The entire infrastructure is deployed automatically using a single terraform apply command.

Infrastructure Created:
The following AWS resources are created:
1.Networking
-1 VPC (10.0.0.0/16)
-1 Public Subnet
-1 Private Subnet
-1 Internet Gateway
-1 Public Route Table
-Route Table Association for the Public Subnet
2.Security
   a. Web Security Group
-Allows SSH (22) only from my public IP
-Allows HTTP (80) from anywhere (0.0.0.0/0)
b.Database Security Group
-Allows MySQL (3306) only from the Web Security Group
-No public access
3.Compute
-1 EC2 Web Server in the public subnet
-Automatically installs Apache using user_data
-Displays:
Hello from Your-Name web server
-1 EC2 Database Server in the private subnet
-No public IP address

Additional Features:
-Uses the latest Amazon Linux 2 AMI through a Terraform data source.
-Allocates and associates an Elastic IP to the web server.
-Supports SSH access using an EC2 Key Pair.
-Uses an S3 remote backend with state locking (use_lockfile = true).

Project Structure:
project-1/
├── backend.tf
├── provider.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── userdata.sh
└── README.md


Deployment Steps:
Step 1 – Initialize Terraform
terraform init
Step 2 – Format the Configuration
terraform fmt
Step 3 – Validate the Configuration
terraform validate
Step 4 – Review the Execution Plan
terraform plan
Step 5 – Deploy the Infrastructure
terraform apply
Step 6 – Destroy the Infrastructure
terraform destroy

Terraform Outputs:
1.vpc_id
2.web_public_ip
3.web_public_url
4.db_private_ip

Expected Screenshots:
1.Successful terraform apply
2.Web page showing:
Hello from Your-Name web server
3.Successful terraform destroy
