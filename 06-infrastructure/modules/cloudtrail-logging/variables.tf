variable "trail_name" {
  type    = string
  default = "northbridge-lab-trail"
}

variable "region" {
  type    = string
  default = "eu-west-2"
}

variable "owner" {
  type        = string
  description = "Role accountable for the logs."
}