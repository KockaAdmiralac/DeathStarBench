#!/sbin/openrc-run

name="iperf3-client"
description="iperf3 client"
command="/bin/sh"
command_args="-c 'echo sleeping; sleep 60; echo waking; ip=\$(dig +short A iperf3); echo \$ip; iperf3 -c \$ip -t 300 -P 16'"
depend() {
	after net
}
