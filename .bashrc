#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

add_env() {
  # Usage: add_env env-variable value command test
  # Parameters
  #   env-var
  #     Environment variable
  #   value
  #     Value to be assigned
  #   command
  #     Only assign value if command exists (hash command to be true)
  #   test
  #     Only assign if test exists ([[ -e test ]] to be true)
  [[ "x$3" != "x" ]] && ! hash "$3" &>/dev/null && return
  [[ "x$4" != "x" ]] && [ ! -e "$4" ] && return
  export "$1"="$2"
}

add_alias() {
  # usage: add_alias alias-name string [command]
  # parameters
  #   alias-name
  #     name of the alias
  #   string
  #     Value of the string assigned to the alias-name. If command is omitted
  #     the string must be a valid command (hash command to be true)
  #   command
  #     command to be tested. Only assign if hash command is true

  [[ "x$4" != "x" ]] && [ ! -e "$4" ] && return

  if [[ "x$3" != "x" ]]; then
  	hash "$3" &>/dev/null && alias "$1"="$2"
  else
  	hash "$2" &>/dev/null && alias "$1"="$2"
  fi
}

# Import aliases
[[ -d ~/.bashrc.d ]] && source ~/.bashrc.d/*

# Add user bin to PATH
dir="$HOME/bin"
[ -d "$dir" ] && add_env PATH "$dir:$PATH" "" $dir

# bash history: ignore space and ignore duplicates
HISTCONTROL="ignoreboth"
HISTSIZE=50000
HISTFILESIZE="${HISTSIZE}"
HISTIGNORE="ls:la:ll:l:tree:vdir:history:exit:prodaccess"

# bash colored man pages
man() {
	env LESS_TERMCAP_mb=$'\E[01;31m' \
		LESS_TERMCAP_md=$'\E[01;38;5;74m' \
		LESS_TERMCAP_me=$'\E[0m' \
		LESS_TERMCAP_se=$'\E[0m' \
		LESS_TERMCAP_so=$'\E[38;5;246m' \
		LESS_TERMCAP_ue=$'\E[0m' \
		LESS_TERMCAP_us=$'\E[04;38;5;146m' \
		man "$@"
}

# enable bash completion for sudo
complete -cf sudo

# Prompt
PS1='[\u@\h \W]\$ '
