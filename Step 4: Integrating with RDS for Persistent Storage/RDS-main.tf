  resource "aws_db_instance" "db_instance" {
    allocated_storage    = 20
    engine               = "mysql"
    engine_version       = "8.0"
    instance_class       = "db.t3.micro"
    name                 = "microservicesdb"
    username             = "admin"
    password             = "password"
    parameter_group_name = "default.mysql8.0"
    skip_final_snapshot  = true

    vpc_security_group_ids = [aws_security_group.eks_sg.id]
    db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  }

  resource "aws_db_subnet_group" "rds_subnet_group" {
    name       = "rds-subnet-group"
    subnet_ids = [aws_subnet.private_subnet.id]

    tags = {
      Name = "RDS Subnet Group"
    }
  }