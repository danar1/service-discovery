

data "aws_subnet_ids" "subnets" {
    vpc_id = var.vpc_id
}



resource "aws_security_group" "ansible-sg" {
 name        = "ansible-sg"
 description = "security group for ansible servers"
 vpc_id      = var.vpc_id
  egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  ingress {
   from_port   = 8
   to_port     = 0
   protocol    = "icmp"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_instance" "ansible-server" {
  count = 1

  ami           = data.aws_ami.ubuntu-18.id
  instance_type = "t2.micro"

  associate_public_ip_address = true

  subnet_id = var.subnet_id

  vpc_security_group_ids = [aws_security_group.ansible-sg.id]
  key_name               = aws_key_pair.service_discovery_key.key_name

  tags = {
    Name = "Ansible-server"
  }
}


