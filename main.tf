resource "aws_instance" "example" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name               = aws_key_pair.auth.id
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get upgrade -y
              wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian/jenkins.io-2023.key
              echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
              apt-get update
              apt-get install fontconfig -y
              apt-get install openjdk-17-jre -y
              apt-get install jenkins -y
              systemctl enable jenkins
              systemctl start jenkins  
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "Jenkins"
  }
}

resource "aws_key_pair" "auth" {
  key_name = "ltskey"
  public_key = file("/var/lib/jenkins/workspace/TFJenkinsDemo/ltskey.pub")
}

resource "aws_security_group" "instance" {
  name = "Jenkins-SG"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
   egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    name = "Jenkins-SG"
  }
}

