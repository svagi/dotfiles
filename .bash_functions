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

### Container aliases

# cURL with HTTP/2 support
curl() {
	docker run --rm -t svagi/curl "$@"
}

# HTTPie
http() {
	docker run --rm -t jess/httpie "$@"
}

# HTTPie with HTTP/2 support
http2() {
	docker run --rm -t svagi/httpie "$@"
}

python() {
	docker run --rm -it python:alpine "$@"
}
