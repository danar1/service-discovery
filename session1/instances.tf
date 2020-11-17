resource "aws_instance" "consul_server" {

  ami           = lookup(var.ami, var.region)
  instance_type = "t2.micro"
  key_name      = var.key_name

  iam_instance_profile   = aws_iam_instance_profile.consul-join.name
  vpc_security_group_ids = [aws_security_group.opsschool_consul.id]

  tags = {
    Name = "opsschool-server"
    consul_server = "true"
  }

}

resource "aws_instance" "consul_agent" {

  ami           = lookup(var.ami, var.region)
  instance_type = "t2.micro"
  key_name      = var.key_name

  iam_instance_profile   = aws_iam_instance_profile.consul-join.name
  vpc_security_group_ids = [aws_security_group.opsschool_consul.id]

  tags = {
    Name = "opsschool-agent"
  }
}

output "server" {
  value = aws_instance.consul_server.public_dns
}

output "agent" {
  value = aws_instance.consul_agent.public_dns
}
