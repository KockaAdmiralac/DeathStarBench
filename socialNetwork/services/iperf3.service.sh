#!/sbin/openrc-run

name="iperf3"
description="iperf3 server"
command="/usr/bin/iperf3"
command_args="-s"
depend() {
	after net
}
