provider "aws" {
  region = "us-east-1"
}
resource "aws_launch_template" "example" {
 image_id        = "ami-0866a3c8686eaeeba"
 instance_type   = "t2.micro"
 vpc_security_group_ids = [aws_security_group.instance.id]
 user_data = filebase64("${path.module}/web-install.sh")

 
}


resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_template.example
  min_size = 1
  max_size = 10

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}