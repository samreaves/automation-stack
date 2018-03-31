# Define our first VPC
resource "aws_vpc" "automation_stack_vpc" {
  cidr_block = "200.0.0.0/16"
  tags {
    Name = "automation_stack_vpc"
  }
}

# Internet gateway for the public subnet
# References the earlier created AWS VPC resource titled automation_stack_vpc
resource "aws_internet_gateway" "automation_stack_internet_gateway" {
  vpc_id = "${aws_vpc.automation_stack_vpc.id}"
  tags {
    Name = "automation_stack_internet_gateway"
  }
}

# Public subnet
# References AWS VPC resource titled automation_stack_vpc
resource "aws_subnet" "automation_stack_public_subnet" {
  vpc_id = "${aws_vpc.automation_stack_vpc.id}"
  cidr_block = "200.0.0.0/24"
  availability_zone = "us-east-1a"
  tags {
    Name = "automation_stack_public_subnet"
  }
}

# Routing table for public subnet
# References Internet Gateway and VPC
resource "aws_route_table" "automation_stack_routing_table_for_public_subnet" {
  vpc_id = "${aws_vpc.automation_stack_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.automation_stack_internet_gateway.id}"
  }
  tags {
    Name = "automation_stack_routing_table_for_public_subnet"
  }
}

# Associate the routing table to public subnet
resource "aws_route_table_association" "automation_stack_public_subnet_routing_table_association" {
  subnet_id = "${aws_subnet.automation_stack_public_subnet.id}"
  route_table_id = "${aws_route_table.automation_stack_routing_table_for_public_subnet.id}"
}

# ECS Instance Security group
resource "aws_security_group" "automation_stack_security_group" {
    name = "automation_stack_security_group"
    description = "Test public access security group"
    vpc_id = "${aws_vpc.automation_stack_vpc.id}"

   ingress {
       from_port = 22
       to_port = 22
       protocol = "tcp"
       cidr_blocks = [
          "0.0.0.0/0"
       ]
   }

   ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = [
          "0.0.0.0/0"
      ]
   }

   ingress {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = [
          "0.0.0.0/0"
      ]
    }

   ingress {
      from_port = 0
      to_port = 0
      protocol = "tcp"
      cidr_blocks = [
         "${var.automation_stack_public__cidr}"
      ]
    }

    egress {
        # allow all traffic to private SN
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    }

    tags {
       Name = "automation_stack_public_sg"
     }
}
