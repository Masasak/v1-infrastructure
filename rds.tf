locals {
  db_type              = "db.t3.micro"
  db_engine            = "mysql"
  db_storage_size      = 20
  db_username          = "root"
  db_public_accessible = false
}

resource "aws_security_group" "rds_sg" {
  name        = "SnapVibe-rds-sg"
  description = "RDS sg only port 3306"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "SnapVibe-rds" {
  identifier             = "${local.name_prefix}-rds"
  allocated_storage      = local.db_storage_size
  engine                 = local.db_engine
  instance_class         = local.db_type
  availability_zone      = "${data.aws_region.current.name}a"
  username               = local.db_username
  password               = var.rds_root_password
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  publicly_accessible    = local.db_public_accessible
}
