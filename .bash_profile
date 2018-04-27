#!/bin/bash

# bash_profile

# Load dotfiles
files=(
  $HOME/.bash_options # Options
  $HOME/.bash_exports # Exports
  $HOME/.bash_aliases # Aliases
  $HOME/.bash_functions # Functions
  $HOME/.bash_prompt # Custom bash prompt
  $HOME/.bash_paths # Path modifications
  $(brew --prefix)/etc/bash_completion # Bash completion (installed via Homebrew)
  $(brew --prefix nvm)/nvm.sh
  $HOME/.bash_profile.local # Local and private settings not under version control
)

# if these files are readable, source them
for index in ${!files[*]}
do
  if [[ -r ${files[$index]} ]]; then
    source ${files[$index]}
  fi
done
unset index
unset files
