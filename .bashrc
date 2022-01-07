#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias yt-dl='youtube-dl'

# PS1 color config:
#
# \[\033[COLORm\]
#
# the color numbers being:
# black: 30
# blue: 34
# cyan: 36
# green: 32
# purple: 35
# red: 31
# white: 37
# yellow: 33
# clear color: 00

BRACKET_COLOR=$'\033[31m'
USER_COLOR=$'\033[33m'
HOST_COLOR=$'\033[36m'
PWD_COLOR=$'\033[32m'
OTHERS_COLOR=$'\033[00m'
CMD_SIGN='$' # I really don't know how to name this one lol

# if current user is root
if [[ $EUID == 0 ]]
then
	USER_COLOR=$'\033[31m'
	CMD_SIGN='#'
fi

PS1='${BRACKET_COLOR}[${USER_COLOR}\u${OTHERS_COLOR}@${HOST_COLOR}\h ${PWD_COLOR}\W${BRACKET_COLOR}]${OTHERS_COLOR}${CMD_SIGN} '

gh-clone () {
	git clone https://github.com/$1
}

extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1     ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1     ;;
             *.rar)       rar x $1       ;;
             *.gz)        gunzip $1      ;;
             *.tar)       tar xf $1      ;;
             *.tbz2)      tar xjf $1     ;;
             *.tgz)       tar xzf $1     ;;
             *.zip)       unzip $1       ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

