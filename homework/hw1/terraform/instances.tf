resource "aws_instance" "consul_server" {

  count                  = var.consul_servers_count
  subnet_id = var.subnet_id

  ami           = data.aws_ami.ubuntu-18.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.service_discovery_key.key_name
  associate_public_ip_address = true

  iam_instance_profile   = aws_iam_instance_profile.consul-join.name
  vpc_security_group_ids = [aws_security_group.opsschool_consul.id]

  tags = {
    Name = "opsschool-server"
    consul_server = "true"
  }

}

resource "aws_instance" "consul_agent" {

  count                  = var.consul_agent_count
  subnet_id = var.subnet_id

  ami           = data.aws_ami.ubuntu-18.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.service_discovery_key.key_name
  associate_public_ip_address = true

  iam_instance_profile   = aws_iam_instance_profile.consul-join.name
  vpc_security_group_ids = [aws_security_group.opsschool_consul.id]

  tags = {
    Name = "opsschool-agent"
  }
}
