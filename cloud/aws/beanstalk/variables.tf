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

# AWS beanstalk detectors specific

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

# Health detectors

variable "health_disabled" {
  description = "Disable all alerting rules for health detector"
  type        = bool
  default     = null
}

variable "health_disabled_critical" {
  description = "Disable critical alerting rule for health detector"
  type        = bool
  default     = null
}

variable "health_disabled_warning" {
  description = "Disable warning alerting rule for health detector"
  type        = bool
  default     = null
}

variable "health_notifications" {
  description = "Notification recipients list per severity overridden for health detector"
  type        = map(list(string))
  default     = {}
}

variable "health_aggregation_function" {
  description = "Aggregation function and group by for health detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "health_transformation_function" {
  description = "Transformation function for health detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='10m')"
}

variable "health_threshold_critical" {
  description = "Critical threshold for health detector"
  type        = number
  default     = 20
}

variable "health_threshold_warning" {
  description = "Warning threshold for health detector"
  type        = number
  default     = 15
}

# Latency_p90 detectors

variable "latency_p90_disabled" {
  description = "Disable all alerting rules for latency_p90 detector"
  type        = bool
  default     = null
}

variable "latency_p90_disabled_critical" {
  description = "Disable critical alerting rule for latency_p90 detector"
  type        = bool
  default     = null
}

variable "latency_p90_disabled_warning" {
  description = "Disable warning alerting rule for latency_p90 detector"
  type        = bool
  default     = null
}

variable "latency_p90_notifications" {
  description = "Notification recipients list per severity overridden for latency_p90 detector"
  type        = map(list(string))
  default     = {}
}

variable "latency_p90_aggregation_function" {
  description = "Aggregation function and group by for latency_p90 detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "latency_p90_transformation_function" {
  description = "Transformation function for latency_p90 detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='15m')"
}

variable "latency_p90_threshold_critical" {
  description = "Critical threshold for latency_p90 detector"
  type        = number
  default     = 0.5
}

variable "latency_p90_threshold_warning" {
  description = "Warning threshold for latency_p90 detector"
  type        = number
  default     = 0.3
}

# app_5xx_error_rate detectors

variable "app_5xx_error_rate_disabled" {
  description = "Disable all alerting rules for 5xx_error_rate detector"
  type        = bool
  default     = null
}

variable "app_5xx_error_rate_disabled_critical" {
  description = "Disable critical alerting rule for 5xx_error_rate detector"
  type        = bool
  default     = null
}

variable "app_5xx_error_rate_disabled_warning" {
  description = "Disable warning alerting rule for 5xx_error_rate detector"
  type        = bool
  default     = null
}

variable "app_5xx_error_rate_notifications" {
  description = "Notification recipients list per severity overridden for 5xx_error_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "app_5xx_error_rate_aggregation_function" {
  description = "Aggregation function and group by for 5xx_error_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "app_5xx_error_rate_transformation_function" {
  description = "Transformation function for 5xx_error_rate detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".sum(over='15m')"
}

variable "app_5xx_error_rate_threshold_critical" {
  description = "Critical threshold for 5xx_error_rate detector"
  type        = number
  default     = 5
}

variable "app_5xx_error_rate_threshold_warning" {
  description = "Warning threshold for 5xx_error_rate detector"
  type        = number
  default     = 3
}

# Root_filesystem_usage detectors

variable "root_filesystem_usage_disabled" {
  description = "Disable all alerting rules for root_filesystem_usage detector"
  type        = bool
  default     = null
}

variable "root_filesystem_usage_disabled_critical" {
  description = "Disable critical alerting rule for root_filesystem_usage detector"
  type        = bool
  default     = null
}

variable "root_filesystem_usage_disabled_warning" {
  description = "Disable warning alerting rule for root_filesystem_usage detector"
  type        = bool
  default     = null
}

variable "root_filesystem_usage_notifications" {
  description = "Notification recipients list per severity overridden for root_filesystem_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "root_filesystem_usage_aggregation_function" {
  description = "Aggregation function and group by for root_filesystem_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "root_filesystem_usage_transformation_function" {
  description = "Transformation function for root_filesystem_usage detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".max(over='5m')"
}

variable "root_filesystem_usage_threshold_critical" {
  description = "Critical threshold for root_filesystem_usage detector"
  type        = number
  default     = 90
}

variable "root_filesystem_usage_threshold_warning" {
  description = "Warning threshold for root_filesystem_usage detector"
  type        = number
  default     = 80
}

