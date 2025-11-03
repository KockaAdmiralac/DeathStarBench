#!/sbin/openrc-run

name="redis"
description="Redis server"
command="/usr/local/bin/redis-server"
pidfile="/run/redis.pid"
depend() {
	after net
}
