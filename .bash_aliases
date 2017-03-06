#!/bin/bash

# bash_aliases

# Allow aliases to be with sudo
alias sudo="sudo "

# Easier navigation: .., ..., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"

# List dir contents aliases
# ref: http://ss64.com/osx/ls.html

# Long form no user group, color
alias l="ls -oG"

# Long form (Ubuntu)
alias ll='ls -alF'

# Order by last modified, long form no user group, color
alias lt="ls -toG"

# List all except . and ..., color, mark file types, long form no user group, file size
alias la="ls -AGFoh"

# List all except . and ..., color, mark file types, long form no use group, order by last modified, file size
alias lat="ls -AGFoth"

# copy file interactive
alias cp='cp -i'

# move file interactive
alias mv='mv -i'

# untar
alias untar='tar xvf'

# IP address
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

# Flush DNS cache
alias flushdns="dscacheutil -flushcache"

# Copy my public key to the pasteboard
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | printf '=> Public key copied to pasteboard.\n'"

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Show/hide hidden files in Finder
alias showdotfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidedotfiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
