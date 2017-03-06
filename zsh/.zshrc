d=~/.dircolors
test -r $d && eval "$(dircolors -b $d)"
# Path to your oh-my-zsh installation.
export ZSH=/home/cauchy/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="amuse"
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

#z Uncomment the following line to disable bi-weekly auto-update checks.
# uDISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git notify)


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
# ZSH_THEME_GIT_PROMPT_CLEAN=""

export LD_LIBRARY_PATH=/opt/oracle/instantclient_12_1:/usr/local/lib/:$LD_LIBRARY_PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH
export EDITOR=vim
export VISUAL=nvim-qt
#FreeType subpixel hinting for better font rendering(readability)
#https://wiki.archlinux.org/index.php/font_configuration#Presets
export FT2_SUBPIXEL_HINTING=1
export TZ='Europe/Budapest'
HISTFILE=~/.histfile
HISTSIZE=10000
HIST_STAMPS="yyyy-mm-dd"
SAVEHIST=10000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
unsetopt CORRECT
setopt PRINT_EXIT_VALUE
setopt CHECK_JOBS
setopt LIST_BEEP
unsetopt NOMATCH
unsetopt HUP
source $ZSH/oh-my-zsh.sh
# End of lines added by compinstall
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/cauchy/.zshrc'
autoload -Uz compinit
compinit
# Pacman alias examples
alias pacupg='sudo pacman -Syu' # Synchronize with repositories and then upgrade packages that are out of date on the local system.
alias pacdl='pacman -Sw' # Download specified package(s) as .tar.xz ball
alias pacin='sudo pacman -S' # Install specific package(s) from the repositories
alias pacins='sudo pacman -U' # Install specific package not from the repositories but from a file 
alias pacre='sudo pacman -R' # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman -Rns' # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman -Si' # Display information about a given package in the repositories
alias pacreps='pacman -Ss' # Search for package(s) in the repositories
alias pacloc='pacman -Qi' # Display information about a given package in the local database
alias paclocs='pacman -Qs' # Search for package(s) in the local database
alias paclo="pacman -Qdt" # List all packages which are orphaned
alias pacc="sudo pacman -Scc" # Clean cache - delete all the package files in the cache
alias paclf="pacman -Ql" # List all files installed by a given package
alias pacown="pacman -Qo" # Show package(s) owning the specified file(s)
alias pacexpl="pacman -D --asexp" # Mark one or more installed packages as explicitly installed 
alias pacimpl="pacman -D --asdep" # Mark one or more installed packages as non explicitly installed

# Additional pacman alias examples
alias pacupd='sudo pacman -Sy && sudo abs' # Update and refresh the local package and ABS databases against repositories
alias pacinsd='sudo pacman -S --asdeps' # Install given package(s) as dependencies
alias pacmir='sudo pacman -Syy' # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist
alias upgrade='pacaur -Syua --noconfirm'
alias grep='grep --color=always'
alias l='ls -alh --color=always'
alias svim='sudo vim'
alias szd='cd /media/data/akos/Dropbox/Dropbox/szd'

# make directory and change current working directory shortcut
mkcdir ()
{
  mkdir -p -- "$1" && cd -P -- "$1"
}
# watch for tex file changes and refresh pdf file
latexWatch(){
  while true; do
    inotifywait -e modify $1;
    latexmk -halt-on-error -pdf $1;
  done
}
