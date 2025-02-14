
 resource "aws_launch_configuration" "jenkins_lc" {
    image_id      = "ami-0abcdef1234567890"
    instance_type = "t3.medium"
    key_name      = "your-key-pair"
    security_groups = [aws_security_group.jenkins_sg.id]

    lifecycle {
      create_before_destroy = true
    }

    user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y java-1.8.0-openjdk
              sudo wget -O /etc/yum.repos.d/jenkins.repo \
                https://pkg.jenkins.io/redhat-stable/jenkins.repo
              sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
              sudo yum install -y jenkins
              sudo systemctl start jenkins
              sudo systemctl enable jenkins
              EOF
  }

  resource "aws_autoscaling_group" "jenkins_asg" {
    launch_configuration = aws_launch_configuration.jenkins_lc.id
    min_size             = 2
    max_size             = 4
    desired_capacity     = 2
    vpc_zone_identifier  = [aws_subnet.public_subnet.id]

    tags = [
      {
        key                 = "Name"
        value               = "Jenkins Instance"
        propagate_at_launch = true
      },
    ]
  }