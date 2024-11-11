variable "os" {
  type        = string
  description = "The operating system."
  default     = "ubuntu"
}

variable "os_type" {
  type        = string
  description = "The operating system version."
  default     = "linux"
}

variable "os_distribution" {
  type        = string
  description = "The operating system version."
  default     = "debian" # debian, rhel
}

variable "os_version" {
  type        = string
  description = "The operating system version."
  default     = "20.04"
}

variable "role" {
  type        = string
  description = "The role of the image."
  default     = "base"
}

variable "cloud_override" {
  type        = list(string)
  description = "Overrides for cloud-specific variables."
  default     = ["source.amazon-ebs.this"] # Set to all when ready. 
}

# Shell script variables

variable "build_shell_scripts" {
  type        = list(string)
  description = "List of build scripts to run."
  default     = []
}

variable "build_shell_script_environment_vars" {
  type        = list(string)
  description = "Environment variables for build scripts."
  default     = null
}

variable "build_shell_script_exit_codes" {
  type        = list(number)
  description = "List of exit codes that are considered successful."
  default     = null
}

variable "build_shell_script_execute_command" {
  type        = string
  description = "The command to execute the shell script."
  default     = null
}

variable "build_shell_script_expect_disconnect" {
  type        = bool
  description = "Expect the connection to disconnect after the script is run."
  default     = null
}

# Powershell script variables

variable "build_powershell_scripts" {
  type        = list(string)
  description = "List of build scripts to run."
  default     = []
}

variable "build_powershell_script_environment_vars" {
  type        = list(string)
  description = "Environment variables for build scripts."
  default     = null
}

variable "build_powershell_script_use_pwsh" {
  type        = bool
  description = "Environment variables for build scripts."
  default     = null
}

variable "build_powershell_script_exit_codes" {
  type        = list(number)
  description = "List of exit codes that are considered successful."
  default     = null
}

variable "build_powershell_script_execute_command" {
  type        = string
  description = "The command to execute the powershell script."
  default     = null
}

variable "build_powershell_script_elevated_user" {
  type        = string
  description = "The command to execute the powershell script."
  default     = "Administrator"
}

variable "build_powershell_script_execution_policy" {
  type        = string
  description = "The command to execute the powershell script."
  default     = null
}