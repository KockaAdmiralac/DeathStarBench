#!/sbin/openrc-run

name="mongo"
description="MongoDB server"
command_user="mongodb:mongodb"
command="/usr/bin/mongod"
command_args="--journal --bind_ip_all --dbpath /var/lib/mongodb"
pidfile="/var/run/mongodb/mongod.pid"
depend() {
	after net
}
