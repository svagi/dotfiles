#!/bin/bash

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

# cURL with HTTP/2 support
curl2() {
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
