variable "bucket_prefix" {
  type        = string
  description = "Start of the bucket name. AWS adds a unique ending."
}

variable "owner" {
  type        = string
  description = "Role accountable for this bucket, for example CTO."
}

variable "data_classification" {
  type        = string
  description = "How sensitive the data is."

  validation {
    condition     = contains(["public", "internal", "confidential", "patient-data"], var.data_classification)
    error_message = "data_classification must be public, internal, confidential or patient-data."
  }
}

variable "environment" {
  type    = string
  default = "lab"
}
variable "force_destroy" {
  type        = bool
  default     = false
  description = "Lab only: allow Terraform to delete the bucket even if it holds files."
}