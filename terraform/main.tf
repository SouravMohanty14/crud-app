provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_key_pair" "deployer" {
  key_name = "deployer-key"
  #public_key = file("~/.ssh/id_rsa.pub")
  public_key = file("${path.module}/id_rsa.pub")
}

## creating security group
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

}

## Allow Flask API (port 5000) access
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 5000
  ip_protocol       = "tcp"
  to_port           = 5000
}


## Allow SSH access (port 22) - Required for debugging and management
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# resource "aws_instance" "crud_app" {
#   ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (update as needed)
#   instance_type = "t2.micro"

#   user_data = <<-EOF
#               #!/bin/bash
#               yum update -y
#               amazon-linux-extras install docker -y
#               service docker start
#               usermod -a -G docker ec2-user
#               docker run -d -p 80:5000 <your-dockerhub-username>/crud-app:latest
#               EOF

#   tags = {
#     Name = "crud-app"
#   }
# }

## creating instance
resource "aws_instance" "crud_instance" {
  ami                    = "ami-0dee22c13ea7a9a67"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
  tags = {
    Name = "crud-app"
  }
  root_block_device {
    encrypted = true
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y docker.io
    sudo systemctl enable docker
    sudo systemctl start docker

    # Pull and run the Docker image from Docker Hub
    sudo docker pull sourav7/crud-app:latest
    sudo docker run -d -p 5000:5000 sourav7/crud-app:latest
  EOF
}

output "ec2_public_ip" {
  value       = aws_instance.crud_instance.public_ip
  description = "Public IP of the EC2 instance"
} 