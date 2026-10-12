variable "trigger" {
  type        = string
  description = "Trigger to bind to, e.g. \"post-login\""
}

variable "actions" {
  type = list(object({
    id           = string
    display_name = string
  }))
  description = "Actions to run on the trigger, in execution order (id is the action_id output of modules/actions)"
}
