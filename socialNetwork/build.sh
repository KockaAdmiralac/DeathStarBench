#!/bin/bash

# This script is used to build DeathStarBench images for Dirigent. It uses
# Docker to add relevant configuration into the images themselves, as Dirigent
# does not support attaching volumes. If using Firecracker as a runtime, it
# adds init systems and relevant startup files into the images, then turns them
# into ext4 filesystems for Firecracker to use.

set -e
IMAGES="redis
mongo
memcached
social-graph-service
compose-post-service
post-storage-service
user-timeline-service
url-shorten-service
user-service
media-service
text-service
unique-id-service
user-mention-service
home-timeline-service
nginx-thrift
media-frontend
jaeger-agent"
RUNTIME="containerd" # containerd or firecracker
DOCKER_USER="kockaadmiralac"

docker build -t $DOCKER_USER/socialnetwork-deps .

for image in $IMAGES
do
    docker build -t "docker.io/$DOCKER_USER/$image" -f "Dockerfile.$image" .
    if [ "$RUNTIME" = "containerd" ]
    then
        docker push "docker.io/$DOCKER_USER/$image"
    else
        docker export --output=rootfs.tar $(docker create $DOCKER_USER/$image) > /dev/null
        mkdir -p rootfs
        sudo tar -xf rootfs.tar -C rootfs
        sudo rm -rf rootfs/dev/*
        sudo rm -rf rootfs/run/*
        echo -e 'nameserver 10.0.1.3' | sudo tee rootfs/etc/resolv.conf > /dev/null
        size=$(du -hd0 rootfs --bytes 2>/dev/null | cut -d$'\t' -f1)
        rootfs_size=$(( size + 500 * 1024 * 1024 ))
        truncate -s "$rootfs_size" "$image.ext4"
        sudo mkfs.ext4 -d rootfs -F "$image.ext4" > /dev/null
        sudo rm rootfs.tar
        sudo rm -rf rootfs
        rsync -av "$image.ext4" "$WORKER:~/cluster_manager/configs/firecracker/$image.ext4"
    fi
done
