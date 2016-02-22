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

# List of all containers
dps() {
	docker ps -a
}

# Delete stopped conntainers
drm() {
	local name=$1
	local state=$(docker inspect --format "{{.State.Running}}" $name 2>/dev/null)
	if [[ "$state" == "false" ]]; then
		docker rm $name
	fi
}

# Delete exited conntainers & all untagged images
dclean() {
	drm
	docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
	docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}

# Search docker hub from browser
dhub() {
	open https://hub.docker.com/search/?q=$1
}

# Docker machine environment switch
dm() {
	if [ $# -eq 0 ]; then
		docker-machine ls
	else
		eval $(docker-machine env $1)
	fi
}

### Container aliases

# cURL with HTTP/2 support
curl() {
	local w=$(pwd)
	docker run --rm -t \
	-v $w:/$w:ro \
	-w $w \
	svagi/curl "$@"
}

# HTTPie
http() {
	local w=$(pwd)
	docker run --rm -t \
		-v $w:/$w:ro \
		-w $w \
		jess/httpie "$@"
}

# HTTPie with HTTP/2 support
http2() {
	local w=$(pwd)
	docker run --rm -t \
		-v $w:/$w:ro \
		-w $w \
		svagi/httpie "$@"
}

# Python
python() {
	docker run --rm -it python:alpine "$@"
}
