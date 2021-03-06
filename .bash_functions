#!/bin/bash

### Helpers

# Determine size of a file or total size of a directory
fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh
	else
		local arg=-sh
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@"
	else
		du $arg .[^.]* *
	fi
}

# Docker compose
dc() {
	docker-compose "$@"
}

# Docker machine
dm() {
	docker-machine "$@"
}

# Docker native
dn() {
	unset ${!DOCKER_*}
}

# Docker machine environment switch
dme() {
	if [ $# -eq 0 ]; then
		eval $(docker-machine env)
	else
		eval $(docker-machine env $1)
	fi
}

# List of all containers
dps() {
	docker ps -a
}

# Delete exited conntainers and all dangling images
drm() {
	docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
	docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}

# Delete exited conntainers, all dangling images and volumes
dclean() {
	drm
	docker volume rm $(docker volume ls -q -f dangling=true) 2>/dev/null
}

# Search in docker hub repository
dhub() {
	if [ "$1" == "-o" ]; then
    open "https://hub.docker.com/search/?isAutomated=0&isOfficial=0&page=1&pullCount=0&starCount=0&q=$2"
	else
		http -b "https://hub.docker.com/v2/search/repositories/" query=="$@"
	fi
}

# Docker Bench for Security
dsec() {
	docker run --rm -it --net host --pid host --cap-add audit_control \
    -v /var/lib:/var/lib \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /usr/lib/systemd:/usr/lib/systemd \
    -v /etc:/etc --label docker_bench_security \
    docker/docker-bench-security
}

### Container aliases

# Alpine container for testing purpose
alpine() {
	docker run --rm -it alpine:latest sh
}

# Debian container for testing purpose
debian() {
	docker run --rm -it debian:latest bash
}

# Ubuntu container for testing purpose
ubuntu() {
	docker run --rm -it ubuntu:latest bash
}

# HTTPie
http() {
	docker run --rm -t --net=host -v $PWD:/$PWD:ro -w $PWD jess/httpie "$@"
}

# HTTPie with HTTP/2 support
http2() {
	docker run --rm -t --net=host -v $PWD:/$PWD:ro -w $PWD svagi/httpie "$@"
}

# LaTex
latex() {
	docker run --rm -i -v $PWD:/tmp -w /tmp svagi/latex-tul xelatex "$@"
}

# Apache Benchmark
ab() {
	docker run --rm -t --net=host svagi/ab "$@"
}

# h2load benchmark
h2load() {
	docker run --rm -t --net=host svagi/h2load "$@"
}

# nghttp - HTTP/2 client
nghttp() {
	docker run --rm -t svagi/nghttp2 nghttp "$@"
}

# Speedtest
speedtest() {
	docker run --rm --net=host tianon/speedtest "$@"
}

# AWS
aws() {
	docker run --rm -it -v ~/.aws:/root/.aws cgswong/aws aws "$@"
}
