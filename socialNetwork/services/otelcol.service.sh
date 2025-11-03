#!/sbin/openrc-run

name="otelcol"
description="OpenTelemetry Collector"
command="/otelcol-contrib"
command_args="--config /etc/otelcol/otel-collector-config.yml"
depend() {
	after net
}
