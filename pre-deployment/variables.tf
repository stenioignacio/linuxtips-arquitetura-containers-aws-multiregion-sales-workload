variable "project_name" {

}

variable "region_primary" {

}

variable "region_secondary" {

}

variable "active_states" {
  type = object({
    us-east-1 = string
    sa-east-1 = string
  })
}

variable "dynamodb_idempotency" {
  type = object({
    name = string

    billing_mode           = string
    point_in_time_recovery = bool

    read_min                 = number
    read_max                 = number
    read_autoscale_threshold = number

    write_min                 = number
    write_max                 = number
    write_autoscale_threshold = number
  })
}

variable "dynamodb_sales" {
  type = object({
    name = string

    billing_mode           = string
    point_in_time_recovery = bool

    read_min                 = number
    read_max                 = number
    read_autoscale_threshold = number

    write_min                 = number
    write_max                 = number
    write_autoscale_threshold = number
  })
}
