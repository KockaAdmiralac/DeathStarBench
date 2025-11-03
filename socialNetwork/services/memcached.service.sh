#!/sbin/openrc-run

name="memcached"
description="High-performance memory object caching system"
command_user="memcache:memcache"
command="/usr/local/bin/memcached"
command_args="-u memcache"
pidfile="/var/run/memcached/memcached.pid"
depend() {
    after net
}
