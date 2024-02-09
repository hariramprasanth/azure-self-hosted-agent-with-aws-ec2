resource "aws_instance" "azureagent_instance" {
  ami                         = "ami-03f4878755434977f"
  instance_type               = "t2.medium"
  count                       = 1
  associate_public_ip_address = true
  key_name                    = "azureagent-ssh-key-pair"
  subnet_id                   = aws_subnet.azureagent_subnet.id
  vpc_security_group_ids      = [aws_security_group.azureagent_security_group.id]
  user_data                   = file("./launch-instance.sh")
  tags = {
    Name    = "azureagent"
    project = "Azure agent"
  }
}