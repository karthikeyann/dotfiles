#!/usr/bin/env bash


### sudo hack: so you can use custom aliases as sudo
###
### NOTE - bash will normally stop recognizing aliases after it sees
### the space after the command sudo, but if it sees an alias that
### ends in a space, it will attempt to detect another alias after.
alias sudo="sudo "

### plz: re-run the last command as root.
alias plz="fc -l -1 | cut -d' ' -f2- | xargs sudo"

### incognito: no saving your command history!
incognito() {
  case $1 in
    start)
    set +o history;;
    stop)
    set -o history;;
    *)
    echo -e "USAGE: incognito start - disable command history.
       incognito stop  - enable command history.";;
  esac
}

alias cls="clear;ls"
### used: recursively gets how much space is used in the current (or given) directory
alias used="du -ch -d 1"

### download: download any and every item linked from that page.
### USAGE - download https://data.gov
alias download="wget --random-wait -r -p --no-parent -e robots=off -U mozilla"


alias mv='mv -i'
alias rm='rm -i'


# grep for a process
function psg {
  FIRST=`echo $1 | sed -e 's/^\(.\).*/\1/'`
  REST=`echo $1 | sed -e 's/^.\(.*\)/\1/'`
  ps aux | grep "[$FIRST]$REST"
}

# CWD
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
# change directories easily
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias cdr='cd $(pwd -P)'

# Git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch -a'
alias gba='git branch -a'
alias gbc='git branch | grep \* | cut -d '\'' '\'' -f2'
alias gbd='git branch -d'
alias gcb='git checkout -b'
alias gcd='git checkout develop'
alias gcf='git config --list'
alias gcm='git checkout master'
alias gco='git checkout'
alias gcon='git config -l'
alias gcs='git commit -S'
alias gcsm='git commit -s -m'
alias gd='git diff'
alias gdw='git diff --word-diff'
alias gvd='git vimdiff'
alias gemail='git config user.email '
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gl='git pull'
alias glg='git log --stat'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glgp='git log --stat -p'
alias glo='git log --oneline --decorate'
alias gname='git config user.name '
alias gr='git remote -v'
alias gra='git remote add'
alias gpom="git push origin master"
#source ~/.git_aliases

parse_git_branch() {
         git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function git-merge-fork() {
  cb="$(parse_git_branch)"
  br="${1:-$cb}"
  upbr="${2:-$br}"
  cmd="\
    git checkout $br;
  git fetch upstream;
  git reset --hard upstream/$upbr;
  git push --force"
  echo "$cmd"
  while true; do
    read -p "Do you wish to execute above commands?[y/n]:" yn
    case $yn in
      [Yy]* ) echo "Executing..."; 
        git checkout $br;
        git fetch upstream;
        git reset --hard upstream/$upbr;
        git push --force
        break;;
      [Nn]* ) break;;
      * ) ;;
    esac
  done
}

alias gitsubsync="git submodule update --recursive"

function gitupstreamsync() {
  cb="$(parse_git_branch)"
  #git checkout fea-drop_duplicates  #my development branch
  git pull
  git pull upstream branch-0.8
  #resolve manually
  #git commit -am "merged branch-0.8"
  #git push origin $cb
  #git push origin fea-drop_duplicates
}

showgb() {
    #export PS1="\[\033[33m\]\$(parse_git_branch)\[\033[00m\]$PS1"
    export PS1="($(parse_git_branch))\[\033[00m\]$PS1"
    #export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\]$ "
}

# File System
alias l='ls -lh'
alias la='ls -lAhrt'
alias lt='ls -lhrt'
alias ll='ls -lh'
alias lsa='ls -lah'
alias md='mkdir -p'
alias fp='readlink -e'
alias vdw="vimdiff -c 'set diffopt+=iwhite'"

# Misc Utility
alias c='clear'
alias calc='bc '
alias gr='grep '
alias cgrep="grep --color=always"
alias highlight='egrep -e ^ -e '
alias clip='xclip -sel clip'
alias ipy=ipython

# Make and change directory at once
alias mkcd='_(){ mkdir -p $1; cd $1; }; _'

# fast find
alias ff='find . -name $1'

#typos
alias sl=ls
alias whic=which
alias v=vi
alias bi=vi

# apt get
alias apt-get='sudo apt-get'

mkcd() {  mkdir $1; cd $1; }
scd() { cd $(dirname $1); }
unmv() { mv $2 $1; }

function ci() {
  local FILE=$1
  local filename=${FILE%:*}
  local linenumb=${FILE##*:}
  #filename=$(echo $FILE | cut -f1 -d:)
  #linenumb=$(echo $FILE | cut -f2 -d:)
  echo $linenumb
  vi $filename -c :$linenumb
  return ${PIPESTATUS[0]}
}

function extract() {

	if [[ "$#" -lt 1 ]]; then
	  echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
	  return 1 #not enough args
	fi

	if [[ ! -e "$1" ]]; then
	  echo -e "File does not exist!"
	  return 2 # File not found
	fi

	DESTDIR="."

	filename=`basename "$1"`

	case "${filename##*.}" in
	  tar)
		echo -e "Extracting $1 to $DESTDIR: (uncompressed tar)"
		tar xvf "$1" -C "$DESTDIR"
		;;
	  gz)
		echo -e "Extracting $1 to $DESTDIR: (gip compressed tar)"
		tar xvfz "$1" -C "$DESTDIR"
		;;
	  tgz)
		echo -e "Extracting $1 to $DESTDIR: (gip compressed tar)"
		tar xvfz "$1" -C "$DESTDIR"
		;;
	  xz)
		echo -e "Extracting  $1 to $DESTDIR: (gip compressed tar)"
		tar xvf -J "$1" -C "$DESTDIR"
		;;
	  bz2)
		echo -e "Extracting $1 to $DESTDIR: (bzip compressed tar)"
		tar xvfj "$1" -C "$DESTDIR"
		;;
      tbz2)
	  	echo -e "Extracting $1 to $DESTDIR: (tbz2 compressed tar)"
	  	tar xvjf "$1" -C "$DESTDIR"
		;;
	  zip)
		echo -e "Extracting $1 to $DESTDIR: (zipp compressed file)"
		unzip "$1" -d "$DESTDIR"
		;;
	  lzma)
	  	echo -e "Extracting $1 : (lzma compressed file)"
		unlzma "$1"
		;;
	  rar)
		echo -e "Extracting $1 to $DESTDIR: (rar compressed file)"
		unrar x "$1" "$DESTDIR"
		;;
	  7z)
		echo -e  "Extracting $1 to $DESTDIR: (7zip compressed file)"
		7za e "$1" -o "$DESTDIR"
		;;
	  xz)
	  	echo -e  "Extracting $1 : (xz compressed file)"
	    unxz  "$1"
	  	;;
	  exe)
	   	cabextract "$1"
	  	;;
	  *)
		echo -e "Unknown archieve format!"
		return
	  	;;
	esac
}

function repeat() {
    number=$1
    shift
    for n in $(seq $number); do
      "$@" || return $?
    done
}

color() { "$@" 2>&1>&3|sed 's,.*,\x1B[31m&\x1B[0m,'>&2; } 3>&1

hmake()
{
  /usr/bin/make "$@" 2>&1 | sed -E \
    -e "s/error/ $(echo -e "\\033[31m" error "\\033[0m"/g)"  \
    -e "s/warning/ $(echo -e "\\033[0;33m" warning "\\033[0m"/g)" \
    -e "s#([^ ]+/[^/]+.*error)#`printf "\033[31m"`\1`printf "\033[0m"`#g" \
    -e "s#([^ ]+/[^/]+.*here)#`printf "\033[34m"`\1`printf "\033[0m"`#g" \
    -e "s#([^ ]+/[^/]+)#`printf "\033[32m"`\1`printf "\033[0m"`#g" \

  return ${PIPESTATUS[0]}
}

hninja()
{
  ninja "$@" 2>&1 | sed -E \
    -e "s/error/ $(echo -e "\\033[31m" error "\\033[0m"/g)"  \
    -e "s/warning/ $(echo -e "\\033[0;33m" warning "\\033[0m"/g)" \
    -e "s#([^ ]+/[^/]+.*error)#`printf "\033[31m"`\1`printf "\033[0m"`#g" \
    -e "s#([^ ]+/[^/]+.*here)#`printf "\033[34m"`\1`printf "\033[0m"`#g" \
    -e "s#([^ ]+/[^/]+)#`printf "\033[32m"`\1`printf "\033[0m"`#g" \

  return ${PIPESTATUS[0]}
}

# usage: clone_rapids karthikeyann cudf 5cudf
clone_rapids () {
  GITHUB_USER=$1
  REPO=$2
  DIR=${3:-$2}
  echo "1 $1 2 $2 @ $DIR"
  git clone --no-tags -c checkout.defaultRemote=upstream -j $(nproc) \
           --recurse-submodules https://github.com/rapidsai/$REPO.git $DIR
  cd $DIR
  git remote show | grep upstream || git remote add -f --tags upstream git@github.com:rapidsai/$REPO.git
  git remote set-url origin git@github.com:$GITHUB_USER/$REPO.git
  git remote set-url --push upstream read_only
  echo -e "cpp/.clangd/\ncpp/compile_commands.json\n*.code-workspace" >> .git/info/exclude
}


# CUDF aliases (for productivity)
alias setcudf="export CUDF_HOME=\`pwd\`"
alias setdf=setcudf
alias ev="echo \$CUDF_HOME"
alias codf="conda activate cudf_dev"
alias scodf="setcudf; codf;"
alias scoda=scodf
alias cppcmake="PARALLEL_LEVEL=20 cmake -DCMAKE_INSTALL_PREFIX=\$CONDA_PREFIX -DCMAKE_CXX11_ABI=ON .."
alias pmake="python setup.py build_ext --inplace --library-dir=../../cpp/build"
alias cdcudf="cd \$CUDF_HOME"
#alias cdcpp="cd \$CUDF_HOME/cpp/build/release &>/dev/null || cd \$CUDF_HOME/cpp/build"
alias cdcpp="cd \$(readlink \$CUDF_HOME/cpp/build/release) &>/dev/null || cd \$CUDF_HOME/cpp/build"
alias cdp="cd \$CUDF_HOME/python/cudf"
alias cdbindings="cd \$CUDF_HOME/python/cudf/cudf/bindings"
alias cdbind=cdbindings
alias ctagsall="cd \$CUDF_HOME; ctags -R --exclude=python/cudf/cudf/bindings/*.pxd --languages=C,C++,Python .; cd -"
alias build="bash -c \"update-environment-variables && CCACHE_BASEDIR=\$PWD ninja -C \$CUDF_ROOT\""
alias b=build

## Custom notifications
alias slacknotify=curl_slack_notify.sh
alias notify=slacknotify
alias notif=slacknotify
alias not=slacknotify


export PATH="$PATH:$HOME/.local/bin"
if [ -f ~/.bash_paths ]; then
    . ~/.bash_paths
fi

