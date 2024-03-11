output "url" {
  value = "http://${aws_lb.web_alb.dns_name}"
}

