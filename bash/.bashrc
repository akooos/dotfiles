xset b off
#
# ~/.bashrc
#

## Pacman alias examples
alias pacupg='sudo pacman -Syu'		# Synchronize with repositories and then upgrade packages that are out of date on the local system.
alias pacin='sudo pacman -S'		# Install specific package(s) from the repositories
alias pacins='sudo pacman -U'		# Install specific package not from the repositories but from a file 
alias pacre='sudo pacman -R'		# Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman -Rns'		# Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman -Si'		# Display information about a given package in the repositories
alias pacreps='pacman -Ss'		# Search for package(s) in the repositories
alias pacloc='pacman -Qi'		# Display information about a given package in the local database
alias paclocs='pacman -Qs'		# Search for package(s) in the local database
alias paclo="pacman -Qdt"		# List all packages which are orphaned
alias pacc="sudo pacman -Scc"		# Clean cache - delete all not currently installed package files
alias paclf="pacman -Ql"		# List all files installed by a given package
alias pacexpl="pacman -D --asexp"	# Mark one or more installed packages as explicitly installed 
alias pacimpl="pacman -D --asdep"	# Mark one or more installed packages as non explicitly installed If not running interactively, don't do anything
alias upgrade="yaourt -Syua --noconfirm"
[[ $- != *i* ]] && return
mkcdir(){
  mkdir -p -- "$1" && cd -P -- "$1"
}
gitps()
{
  local g="$(git rev-parse --git-dir 2>/dev/null)"
  if [ -n "$g" ]; then
    local r
    local b
    if [ -d "$g/rebase-apply" ]
    then
      if test -f "$g/rebase-apply/rebasing"
      then
	r="|REBASE"
      elif test -f "$g/rebase-apply/applying"
      then
	r="|AM"
      else
	r="|AM/REBASE"
      fi
      b="$(git symbolic-ref HEAD 2>/dev/null)"
    elif [ -f "$g/rebase-merge/interactive" ]
    then
      r="|REBASE-i"
      b="$(cat "$g/rebase-merge/head-name")"
    elif [ -d "$g/rebase-merge" ]
    then
      r="|REBASE-m"
      b="$(cat "$g/rebase-merge/head-name")"
    elif [ -f "$g/MERGE_HEAD" ]
    then
      r="|MERGING"
      b="$(git symbolic-ref HEAD 2>/dev/null)"
    else
      if [ -f "$g/BISECT_LOG" ]
      then
	r="|BISECTING"
      fi
      if ! b="$(git symbolic-ref HEAD 2>/dev/null)"
      then
	if ! b="$(git describe --exact-match HEAD 2>/dev/null)"
	then
	  b="$(cut -c1-7 "$g/HEAD")..."
	fi
      fi
    fi

    if [ -n "${1-}" ]; then
      printf "$1" "${b##refs/heads/}$r"
    else
      printf " (%s)" "${b##refs/heads/}$r"
    fi
  fi
}
finalurl()
{
  curl $1 -s -L -I -o /dev/null -w '%{url_effective}'
}
svim(){
  sudo vim $@
}
alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
export PS1="\a\n\e[31;1m\u@\h on \d at \@\n\e[34;1m\w\e[0m \[\$(gitps)\]\n$ "
LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
export LS_COLORS
alias l="ls -alh --color=always"
alias grep="grep --color=always"
alias rm="rm -v"
alias del="mv -iv $@ ~/.Trash"
if [ -x /usr/bin/cowsay -a -x /usr/bin/fortune ]; then
  fortune | cowsay
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
