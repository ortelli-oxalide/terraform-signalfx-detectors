# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx module specific

variable "is_v2" {
  description = "Flag to use HTTP API Gateway (v2) instead of REST API Gateway (v1)"
  type        = bool
  default     = false
}

variable "notifications" {
  description = "Notification recipients list for every detectors"
  type        = list
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

# AWS ApiGateway detectors specific

variable "minimum_traffic" {
  description = "Minimum required traffic to evaluate rate of errors detectors"
  type        = number
  default     = 4
}

# Latency detectors

variable "latency_disabled" {
  description = "Disable all alerting rules for latency detector"
  type        = bool
  default     = null
}

variable "latency_disabled_critical" {
  description = "Disable critical alerting rule for latency detector"
  type        = bool
  default     = null
}

variable "latency_disabled_warning" {
  description = "Disable warning alerting rule for latency detector"
  type        = bool
  default     = null
}

variable "latency_notifications" {
  description = "Notification recipients list for every alerting rules of latency detector"
  type        = list
  default     = []
}

variable "latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of latency detector"
  type        = list
  default     = []
}

variable "latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of latency detector"
  type        = list
  default     = []
}

variable "latency_aggregation_function" {
  description = "Aggregation function and group by for latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "latency_transformation_function" {
  description = "Transformation function for latency detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ""
}

variable "latency_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 600
}

variable "latency_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "latency_threshold_critical" {
  description = "Critical threshold for latency detector"
  type        = number
  default     = 3000
}

variable "latency_threshold_warning" {
  description = "Warning threshold for latency detector"
  type        = number
  default     = 1000
}

# Http_5xx detectors

variable "http_5xx_disabled" {
  description = "Disable all alerting rules for http_5xx detector"
  type        = bool
  default     = null
}

variable "http_5xx_disabled_critical" {
  description = "Disable critical alerting rule for http_5xx detector"
  type        = bool
  default     = null
}

variable "http_5xx_disabled_warning" {
  description = "Disable warning alerting rule for http_5xx detector"
  type        = bool
  default     = null
}

variable "http_5xx_notifications" {
  description = "Notification recipients list for every alerting rules of http_5xx detector"
  type        = list
  default     = []
}

variable "http_5xx_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of http_5xx detector"
  type        = list
  default     = []
}

variable "http_5xx_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of http_5xx detector"
  type        = list
  default     = []
}

variable "http_5xx_aggregation_function" {
  description = "Aggregation function and group by for http_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "http_5xx_transformation_function" {
  description = "Transformation function for http_5xx detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ""
}

variable "http_5xx_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "http_5xx_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "http_5xx_threshold_critical" {
  description = "Critical threshold for http_5xx detector"
  type        = number
  default     = 10
}

variable "http_5xx_threshold_warning" {
  description = "Warning threshold for http_5xx detector"
  type        = number
  default     = 5
}

# Http_4xx detectors

variable "http_4xx_disabled" {
  description = "Disable all alerting rules for http_4xx detector"
  type        = bool
  default     = null
}

variable "http_4xx_disabled_critical" {
  description = "Disable critical alerting rule for http_4xx detector"
  type        = bool
  default     = null
}

variable "http_4xx_disabled_warning" {
  description = "Disable warning alerting rule for http_4xx detector"
  type        = bool
  default     = null
}

variable "http_4xx_notifications" {
  description = "Notification recipients list for every alerting rules of http_4xx detector"
  type        = list
  default     = []
}

variable "http_4xx_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of http_4xx detector"
  type        = list
  default     = []
}

variable "http_4xx_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of http_4xx detector"
  type        = list
  default     = []
}

variable "http_4xx_aggregation_function" {
  description = "Aggregation function and group by for http_4xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "http_4xx_transformation_function" {
  description = "Transformation function for http_4xx detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ""
}

variable "http_4xx_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "http_4xx_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "http_4xx_threshold_critical" {
  description = "Critical threshold for http_4xx detector"
  type        = number
  default     = 40
}

variable "http_4xx_threshold_warning" {
  description = "Warning threshold for http_4xx detector"
  type        = number
  default     = 20
}

