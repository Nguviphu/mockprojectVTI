# 1. Tạo Subnet Group cho RDS 
resource "aws_db_subnet_group" "cms_db_subnet" {
  name       = "cms-97-db-subnet-group"
  subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]
  tags = { Name = "CMS 97 DB Subnet Group" }
}

# 2. Tạo Security Group cho Database
resource "aws_security_group" "rds_sg" {
  name        = "cms-97-rds-sg"
  description = "Allow inbound traffic from EKS/VPC to PostgreSQL"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow PostgreSQL port from VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 3. Khởi tạo RDS PostgreSQL
resource "aws_db_instance" "cms_db" {
  identifier           = "cms-97-postgres-db"
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "15" # Cập nhật phiên bản tự động
  instance_class       = "db.t3.micro" 
  db_name              = "cmsdb97"
  username             = "dbadmin"
  password             = "VtiAcademy123!" 
  
  db_subnet_group_name   = aws_db_subnet_group.cms_db_subnet.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  
  multi_az               = false 
  skip_final_snapshot    = true  
}