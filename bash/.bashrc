xset b off
#
# ~/.bashrc
#
#Exit if this file read by non-interactive shell
#http://askubuntu.com/questions/829069/what-does-i-return-mean
[[ $- != *i* ]] && return

## Pacman alias examples
# Synchronize with repositories and then upgrade packages that are out of date on the local system.
alias pacupg='sudo pacman -Syu'
# Install specific package(s) from the repositories
alias pacin='sudo pacman -S'
# Install specific package not from the repositories but from a file 
alias pacins='sudo pacman -U'
# Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacre='sudo pacman -R'
# Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrem='sudo pacman -Rns'
# Display information about a given package in the repositories
alias pacrep='pacman -Si'
# Search for package(s) in the repositories
alias pacreps='pacman -Ss'
# Display information about a given package in the local database
alias pacloc='pacman -Qi'
# Search for package(s) in the local database
alias paclocs='pacman -Qs'
# List all packages which are orphaned
alias paclo='pacman -Qdt'
# Clean cache - delete all not currently installed package files
alias pacc='sudo pacman -Scc'
# List all files installed by a given package
alias paclf='pacman -Ql'
# Mark one or more installed packages as explicitly installed 
alias pacexpl='pacman -D --asexp'
# Mark one or more installed packages as non explicitly installed If not running interactively, don't do anything
alias pacimpl='pacman -D --asdep'
# Upgrade system
alias upgrade='yaourt -Syua --noconfirm'
# Color ls"
alias ls='ls --color=always'
alias l='ls -alh --color=always'
alias grep='grep --color=always'
# Print what is being deleted
alias rm='rm -v'
# Sudo vim
alias svim="sudo vim $@"
# Safe delete
alias del="mv -iv $@ ~/.Trash"

#Functions
#make and change directory
mkcdir(){
    mkdir -p -- "$1" && cd -P -- "$1"
}

#GIT line for PS1
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
#SystemD start/stop and status print, silly but just fine
service(){
    if [[ "$#" == "2" ]];then

        sudo systemctl $1 $2
        if [[ "$1" != "status" ]]; then
            sudo systemctl status $2
        fi
    else
        echo -n "Bad arguments!"
    fi
}
echoColors(){
  # standard colors
  for C in {40..47}; do
      echo -en "\e[${C}m$C "
  done
  # high intensity colors
  for C in {100..107}; do
      echo -en "\e[${C}m$C "
  done
  # 256 colors
  for C in {16..255}; do
      echo -en "\e[48;5;${C}m$C "
  done
  echo -e "\e(\e[m"
}
finalurl()
{
    curl $1 -s -L -I -o /dev/null -w '%{url_effective}'
}
gitstatus(){
# -*- coding: utf-8 -*-
# gitstatus.sh -- produce the current git repo status on STDOUT
# Functionally equivalent to 'gitstatus.py', but written in bash (not python).
#
# Alan K. Stebbens <aks@stebbens.org> [http://github.com/aks]

if [ -z "${__GIT_PROMPT_DIR}" ]; then
  SOURCE="${BASH_SOURCE[0]}"
  while [ -h "${SOURCE}" ]; do
    DIR="$( cd -P "$( dirname "${SOURCE}" )" && pwd )"
    SOURCE="$(readlink "${SOURCE}")"
    [[ $SOURCE != /* ]] && SOURCE="${DIR}/${SOURCE}"
  done
  __GIT_PROMPT_DIR="$( cd -P "$( dirname "${SOURCE}" )" && pwd )"
fi

gitstatus=$( LC_ALL=C git status --untracked-files=${__GIT_PROMPT_SHOW_UNTRACKED_FILES:-all} --porcelain --branch )

# if the status is fatal, exit now
[[ "$?" -ne 0 ]] && exit 0

num_staged=0
num_changed=0
num_conflicts=0
num_untracked=0
while IFS='' read -r line || [[ -n "$line" ]]; do
  status=${line:0:2}
  while [[ -n $status ]]; do
    case "$status" in
      #two fixed character matches, loop finished
      \#\#) branch_line="${line/\.\.\./^}"; break ;;
      \?\?) ((num_untracked++)); break ;;
      U?) ((num_conflicts++)); break;;
      ?U) ((num_conflicts++)); break;;
      DD) ((num_conflicts++)); break;;
      AA) ((num_conflicts++)); break;;
      #two character matches, first loop
      ?M) ((num_changed++)) ;;
      ?D) ((num_changed++)) ;;
      ?\ ) ;;
      #single character matches, second loop
      U) ((num_conflicts++)) ;;
      \ ) ;;
      *) ((num_staged++)) ;;
    esac
    status=${status:0:(${#status}-1)}
  done
done <<< "$gitstatus"

num_stashed=0
if [[ "$__GIT_PROMPT_IGNORE_STASH" != "1" ]]; then
  stash_file="$( git rev-parse --git-dir )/logs/refs/stash"
  if [[ -e "${stash_file}" ]]; then
    while IFS='' read -r wcline || [[ -n "$wcline" ]]; do
      ((num_stashed++))
    done < ${stash_file}
  fi
fi

clean=0
if (( num_changed == 0 && num_staged == 0 && num_untracked == 0 && num_stashed == 0 && num_conflicts == 0)) ; then
  clean=1
fi

IFS="^" read -ra branch_fields <<< "${branch_line/\#\# }"
branch="${branch_fields[0]}"
remote=
upstream=

if [[ "$branch" == *"Initial commit on"* ]]; then
  IFS=" " read -ra fields <<< "$branch"
  branch="${fields[3]}"
  remote="_NO_REMOTE_TRACKING_"
elif [[ "$branch" == *"no branch"* ]]; then
  tag=$( git describe --tags --exact-match )
  if [[ -n "$tag" ]]; then
    branch="$tag"
  else
    branch="_PREHASH_$( git rev-parse --short HEAD )"
  fi
else
  if [[ "${#branch_fields[@]}" -eq 1 ]]; then
    remote="_NO_REMOTE_TRACKING_"
  else
    IFS="[,]" read -ra remote_fields <<< "${branch_fields[1]}"
    upstream="${remote_fields[0]}"
    for remote_field in "${remote_fields[@]}"; do
      if [[ "$remote_field" == *ahead* ]]; then
        num_ahead=${remote_field:6}
        ahead="_AHEAD_${num_ahead}"
      fi
      if [[ "$remote_field" == *behind* ]]; then
        num_behind=${remote_field:7}
        behind="_BEHIND_${num_behind# }"
      fi
    done
    remote="${behind}${ahead}"
  fi
fi

if [[ -z "$remote" ]] ; then
  remote='.'
fi

if [[ -z "$upstream" ]] ; then
  upstream='^'
fi

#   "$remote" \
#   "$upstream" \
#   $num_staged \
#   $num_conflicts \
#   $num_changed \
#   $num_untracked \
#   $num_stashed \
#   $clean
}
PS1="\e[48;5;232m\a\n\e[38;5;82m\u@\h on \d at \@\e(B\e[m\n\e[48;5;232m\e[38;5;214m\w\e[0m\[\$(gitps)\]\e(B\e[m\n$"

#export PS1="\e[48;5;232m\a\n\e[38;5;82m\u@\h on \d at \@\e(B\e[m\n\e[48;5;232m\e[38;5;190m\w\e[0m\e(B\e[m\n$"
export LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'

if [ -x /usr/bin/cowsay -a -x /usr/bin/fortune ]; then
    fortune | cowsay
fi
source /usr/share/nvm/init-nvm.sh
