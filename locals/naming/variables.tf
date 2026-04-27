variable "project" {
  type        = string
  description = "Project name (e.g., n8n)"
}

variable "environment" {
  type        = string
  description = "Environment name (dev/prod)"
}

variable "location_short" {
  type        = string
  description = "Short region code (e.g., in, eu, us)"
}