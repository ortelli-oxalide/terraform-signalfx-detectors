# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Default notification recipients list per severity"
  type = object({
    critical = list(string)
    major    = list(string)
    minor    = list(string)
    warning  = list(string)
    info     = list(string)
  })
}

variable "prefixes" {
  description = "Prefixes list to prepend between brackets on every monitors names before environment"
  type        = list
  default     = []
}

variable "filter_custom_includes" {
  description = "List of tags to include when custom filtering is used"
  type        = list
  default     = []
}

variable "filter_custom_excludes" {
  description = "List of tags to exclude when custom filtering is used"
  type        = list
  default     = []
}

variable "detectors_disabled" {
  description = "Disable all detectors in this module"
  type        = bool
  default     = false
}

# Docker detectors specific

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_timeframe" {
  description = "Timeframe for system not reporting detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

# cpu detectors

variable "cpu_disabled" {
  description = "Disable all alerting rules for cpu detector"
  type        = bool
  default     = false
}

variable "cpu_disabled_major" {
  description = "Disable major alerting rule for cpu detector"
  type        = bool
  default     = null
}

variable "cpu_disabled_warning" {
  description = "Disable warning alerting rule for cpu detector"
  type        = bool
  default     = null
}

variable "cpu_notifications" {
  description = "Notification recipients list per severity overridden for cpu detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_aggregation_function" {
  description = "Aggregation function and group by for cpu detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_transformation_function" {
  description = "Transformation function for cpu detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='1h')"
}

variable "cpu_threshold_major" {
  description = "major threshold for cpu detector"
  type        = number
  default     = 50
}

variable "cpu_threshold_warning" {
  description = "Warning threshold for cpu detector"
  type        = number
  default     = 75
}

# throttling detectors

variable "throttling_disabled" {
  description = "Disable all alerting rules for throttling detector"
  type        = bool
  default     = false
}

variable "throttling_disabled_major" {
  description = "Disable major alerting rule for throttling detector"
  type        = bool
  default     = null
}

variable "throttling_disabled_warning" {
  description = "Disable warning alerting rule for throttling detector"
  type        = bool
  default     = null
}

variable "throttling_notifications" {
  description = "Notification recipients list per severity overridden for throttling detector"
  type        = map(list(string))
  default     = {}
}

variable "throttling_aggregation_function" {
  description = "Aggregation function and group by for throttling detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "throttling_transformation_function" {
  description = "Transformation function for throttling detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".max(over='5m')"
}

variable "throttling_threshold_major" {
  description = "major threshold for throttling detector"
  type        = number
  default     = 1000 # = 1 millisecond in nanoseconds
}

variable "throttling_threshold_warning" {
  description = "Warning threshold for throttling detector"
  type        = number
  default     = 1000000000 # = 1 second in nanoseconds
}

# Memory detectors

variable "memory_disabled" {
  description = "Disable all alerting rules for memory detector"
  type        = bool
  default     = false
}

variable "memory_disabled_major" {
  description = "Disable major alerting rule for memory detector"
  type        = bool
  default     = null
}

variable "memory_disabled_warning" {
  description = "Disable warning alerting rule for memory detector"
  type        = bool
  default     = null
}

variable "memory_notifications" {
  description = "Notification recipients list per severity overridden for memory detector"
  type        = map(list(string))
  default     = {}
}

variable "memory_aggregation_function" {
  description = "Aggregation function and group by for memory detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_transformation_function" {
  description = "Transformation function for memory detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='15m')"
}

variable "memory_threshold_major" {
  description = "major threshold for memory detector"
  type        = number
  default     = 90
}

variable "memory_threshold_warning" {
  description = "Warning threshold for memory detector"
  type        = number
  default     = 95
}

