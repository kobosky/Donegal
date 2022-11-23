output "vpc_id" {
  value = aws_vpc.kobo.id
}

output "vpc_cidr_block" {
  value = aws_vpc.kobo.cidr_block
}