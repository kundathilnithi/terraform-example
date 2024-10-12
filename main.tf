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
  
  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }
  min_size = 1
  max_size = 10
  availability_zones = ["us-east-1a"]
  vpc_zone_identifier  = data.aws_subnets.default.ids

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