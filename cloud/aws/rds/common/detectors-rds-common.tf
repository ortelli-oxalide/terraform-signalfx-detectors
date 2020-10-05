resource "signalfx_detector" "heartbeat" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS RDS heartbeat"

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('CPUUtilization', filter=filter('stat', 'mean') and filter('namespace', 'AWS/RDS') and ${module.filter-tags.filter_custom}).mean(by=['DBInstanceIdentifier']).publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=['DBInstanceIdentifier'], duration='${var.heartbeat_timeframe}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications["critical"])
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "cpu_90_15min" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS RDS instance CPU"

  program_text = <<-EOF
    signal = data('CPUUtilization', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*') and ${module.filter-tags.filter_custom})${var.cpu_90_15min_aggregation_function}${var.cpu_90_15min_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_90_15min_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.cpu_90_15min_threshold_warning}) and when(signal <= ${var.cpu_90_15min_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.cpu_90_15min_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_90_15min_disabled_critical, var.cpu_90_15min_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_90_15min_notifications, "critical", []), var.notifications["critical"])
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.cpu_90_15min_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.cpu_90_15min_disabled_warning, var.cpu_90_15min_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.cpu_90_15min_notifications, "warning", []), var.notifications["warning"])
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "free_space_low" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS RDS instance free space"

  program_text = <<-EOF
    signal = data('FreeStorageSpace', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*') and ${module.filter-tags.filter_custom})${var.free_space_low_aggregation_function}${var.free_space_low_transformation_function}.publish('signal')
    detect(when(signal < ${var.free_space_low_threshold_critical})).publish('CRIT')
    detect(when(signal < ${var.free_space_low_threshold_warning}) and when(signal >= ${var.free_space_low_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too low < ${var.free_space_low_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.free_space_low_disabled_critical, var.free_space_low_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.free_space_low_notifications, "critical", []), var.notifications["critical"])
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too low < ${var.free_space_low_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.free_space_low_disabled_warning, var.free_space_low_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.free_space_low_notifications, "warning", []), var.notifications["warning"])
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

resource "signalfx_detector" "replica_lag" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] AWS RDS replica lag"

  program_text = <<-EOF
    signal = data('ReplicaLag', filter=filter('namespace', 'AWS/RDS') and filter('stat', 'mean') and filter('DBInstanceIdentifier', '*') and ${module.filter-tags.filter_custom})${var.replica_lag_aggregation_function}${var.replica_lag_transformation_function}.publish('signal')
    detect(when(signal > ${var.replica_lag_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.replica_lag_threshold_warning}) and when(signal <= ${var.replica_lag_threshold_critical})).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.replica_lag_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.replica_lag_disabled_critical, var.replica_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.replica_lag_notifications, "critical", []), var.notifications["critical"])
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }

  rule {
    description           = "is too high > ${var.replica_lag_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.replica_lag_disabled_warning, var.replica_lag_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.replica_lag_notifications, "warning", []), var.notifications["warning"])
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

