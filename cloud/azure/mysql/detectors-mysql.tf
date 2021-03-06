resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure MySQL heartbeat"

  program_text = <<-EOF
        from signalfx.detectors.not_reporting import not_reporting
        base_filter = filter('resource_type', 'Microsoft.DBforMySQL/servers') and filter('primary_aggregation_type', 'true')
        signal = data('active_connections', filter=base_filter and ${module.filter-tags.filter_custom}).publish('signal')
        not_reporting.detector(stream=signal, resource_identifier=['azure_resource_id'], duration='${var.heartbeat_timeframe}').publish('CRIT')
    EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.heartbeat_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "cpu_usage" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure MySQL CPU usage"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.DBforMySQL/servers') and filter('primary_aggregation_type', 'true')
        signal = data('cpu_percent', filter=base_filter and ${module.filter-tags.filter_custom})${var.cpu_usage_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.cpu_usage_threshold_critical}), lasting="${var.cpu_usage_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.cpu_usage_threshold_warning}), lasting="${var.cpu_usage_timer}") and when(signal <= ${var.cpu_usage_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.cpu_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_usage_disabled_critical, var.cpu_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.cpu_usage_notifications_critical, var.cpu_usage_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.cpu_usage_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.cpu_usage_disabled_warning, var.cpu_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.cpu_usage_notifications_warning, var.cpu_usage_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "free_storage" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure MySQL free storage"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.DBforMySQL/servers') and filter('primary_aggregation_type', 'true')
        A = data('storage_percent', filter=base_filter and ${module.filter-tags.filter_custom})${var.free_storage_aggregation_function}
        signal = (100-A).publish('signal')
        detect(when(signal < threshold(${var.free_storage_threshold_critical}), lasting="${var.free_storage_timer}")).publish('CRIT')
        detect(when(signal < threshold(${var.free_storage_threshold_warning}), lasting="${var.free_storage_timer}") and when(signal >= ${var.free_storage_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too low < ${var.free_storage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.free_storage_disabled_critical, var.free_storage_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.free_storage_notifications_critical, var.free_storage_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too low < ${var.free_storage_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.free_storage_disabled_warning, var.free_storage_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.free_storage_notifications_warning, var.free_storage_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "io_consumption" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure MySQL IO consumption"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.DBforMySQL/servers') and filter('primary_aggregation_type', 'true')
        signal = data('io_consumption_percent', filter=base_filter and ${module.filter-tags.filter_custom})${var.io_consumption_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.io_consumption_threshold_critical}), lasting="${var.io_consumption_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.io_consumption_threshold_warning}), lasting="${var.io_consumption_timer}") and when(signal <= ${var.io_consumption_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.io_consumption_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.io_consumption_disabled_critical, var.io_consumption_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.io_consumption_notifications_critical, var.io_consumption_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.io_consumption_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.io_consumption_disabled_warning, var.io_consumption_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.io_consumption_notifications_warning, var.io_consumption_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "memory_usage" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure MySQL memory usage"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.DBforMySQL/servers') and filter('primary_aggregation_type', 'true')
        signal = data('memory_percent', filter=base_filter and ${module.filter-tags.filter_custom})${var.memory_usage_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.memory_usage_threshold_critical}), lasting="${var.memory_usage_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.memory_usage_threshold_warning}), lasting="${var.memory_usage_timer}") and when(signal <= ${var.memory_usage_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.memory_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_usage_disabled_critical, var.memory_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.memory_usage_notifications_critical, var.memory_usage_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.memory_usage_threshold_warning}%"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.memory_usage_disabled_warning, var.memory_usage_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.memory_usage_notifications_warning, var.memory_usage_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "replication_lag" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] Azure MySQL replication lag"

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.DBforMySQL/servers') and filter('primary_aggregation_type', 'true')
        signal = data('seconds_behind_master', filter=base_filter and ${module.filter-tags.filter_custom})${var.replication_lag_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.replication_lag_threshold_critical}), lasting="${var.replication_lag_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.replication_lag_threshold_warning}), lasting="${var.replication_lag_timer}") and when(signal <= ${var.replication_lag_threshold_critical})).publish('WARN')
    EOF

  rule {
    description           = "is too high > ${var.replication_lag_threshold_critical}s"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.replication_lag_disabled_critical, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.replication_lag_notifications_critical, var.replication_lag_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.replication_lag_threshold_warning}s"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.replication_lag_disabled_warning, var.replication_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(var.replication_lag_notifications_warning, var.replication_lag_notifications, var.notifications)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}
