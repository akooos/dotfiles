#git  python reco install miatt
# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
# returns text to add to bash PS1 prompt (includes branch name)
reco_gitrepo_path=/home/akos/Dokumentumok/work/
#nginx public folder
public_path=/home/akos/tmp/jsapi/proxy
build_js() {
    (cd $reco_gitrepo_path/reco/modules/static;
        date +'rebuild js at %Y-%m-%d %H:%M:%S.%N'
        ./gradlew build -Pcustomer=$1 -Phud=true && \
        mkdir -p $public_path/$1 &&  \
        rm -v -rf $public_path/$1/* && \
        cp -vanR build/personalize-$1/js/$1/* $public_path/$1 && \
	chmod 775 $public_path/$1	
	find $public_path/$1 -type f -exec chmod -v o=r {} \;

        date +'done js rebuild at %Y-%m-%d %H:%M:%S.%N'
    )
}
prx(){
    build_js $1
    while inotifywait $reco_gitrepo_path/reco/modules/reco/custom/js/$1.js; do
        build_js $1
    done
}
svim(){
    sudo vim $@
}
mit(){
    which mitmproxy
    killall -9 mitmproxy
    mitmproxy -v --host -p 3333 -s /home/akos/Dokumentumok/work/proxyjq_request/mitm.py
}
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
if [ -x /usr/games/cowsay -a -x /usr/games/fortune ]; then
    fortune | cowsay
fi
#export PS1="\a\n\n\e[31;1m\u@\h on \d at \@\n\e[33;1m\w\e[0m \$( git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' ) \n$ "
export PS1="\a\n\e[31;1m\u@\h on \d at \@\n\e[34;1m\w\e[0m \[\$(gitps)\]\n$ "
LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
export LS_COLORS
alias l="ls -alh --color=always"
alias grep="grep --color=always"
alias rm="rm -v"
alias del="mv -iv $@ ~/.Trash"
export PATH=$PATH:/home/akos/bin
export _JAVA_OPTIONS=-Xmx4096m
