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

# Delete stopped conntainers
drm() {
	local name=$1
	local state=$(docker inspect --format "{{.State.Running}}" $name)
	if [[ "$state" == "false" ]]; then
		docker rm $name
	fi
}

# Delete exited conntainers and all dangling images and volumes
dclean() {
	docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
	docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
	docker volume rm $(docker volume ls -q -f dangling=true) 2>/dev/null
}

# Search docker hub from browser
dhub() {
	open https://hub.docker.com/search/?q=$1
}

### Container aliases

# Alpine container for testing purpose
alpine() {
	docker run --rm -it alpine:latest sh
}

# cURL with HTTP/2 support
curl() {
	docker run --rm -t --net=host -v $PWD:/$PWD:ro -w $PWD svagi/curl "$@"
}

# HTTPie
http() {
	docker run --rm -t --net=host -v $PWD:/$PWD:ro -w $PWD jess/httpie "$@"
}

# HTTPie with HTTP/2 support
http2() {
	docker run --rm -t --net=host -v $PWD:/$PWD:ro -w $PWD svagi/httpie "$@"
}

# Python
python() {
	docker run --rm -it python:alpine "$@"
}

# LaTex
latex() {
	docker run --rm -i -v $PWD:/tmp -w /tmp svagi/latex-tul xelatex "$@"
}

# Apache Benchmark
ab() {
	docker run --rm -t svagi/ab "$@"
}

# h2load benchmark
h2load() {
	docker run --rm -t svagi/h2load "$@"
}

# nghttp - HTTP/2 client
nghttp() {
	docker run --rm -t svagi/nghttp2 nghttp "$@"
}

# Speedtest
speedtest() {
	docker run --rm --net=host tianon/speedtest "$@"
}
