#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias yt-dl='youtube-dl'

complete -cf sudo
complete -cf man

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
if [[ $EUID -eq 0 ]]; then
	USER_COLOR=$'\033[31m'
	CMD_SIGN='#'
fi

PS1='\[${BRACKET_COLOR}\][\[${USER_COLOR}\]\u\[${OTHERS_COLOR}\]@\[${HOST_COLOR}\]\h \[${PWD_COLOR}\]\W\[${BRACKET_COLOR}\]]\[${OTHERS_COLOR}\]${CMD_SIGN} '

gh-clone () {
	git clone https://github.com/$1 $2
}

clipcat () {
	if hash xclip 2>/dev/null; then # checks if xclip is installed
		cat $1 | xclip -selection clipboard
	else
		echo "Hey man, you might wanna install xclip to use this command. :)"
	fi
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

video-dl () {
    if hash youtube-dl 2>/dev/null ; then
        if [ $# -eq 0 ]; then
            echo "You didn't enter any arguments, dumbass."
        elif [ $1 = "-h" ] || [ $1 = "--help" ]; then
            echo "Usage: video-dl [OPTIONS] URL
            -o, --output           Specifies the output file, without the extension
            -c, --convert          Converts the file to the specified format
            -h, --help             Prints this text and exit
            "
        else
            local arguments=("$@")
            local last_arg=""
            local filename=""
            local convert=""
            local video_url=""

            for arg in "${arguments[@]}"; do
                case $last_arg in
                    "-o" | "--output")     filename="$arg" ;;
                    "-c" | "--convert")    convert="$arg"  ;;
                    "" | *)                video_url="$arg";;
                esac

                last_arg="$arg"
            done

            if [ "$filename" = "" ]; then
                filename="%(title)s"
            fi

            youtube-dl -o "${filename}.%(ext)s" -f 'best' "${video_url}"
            local file=$(youtube-dl -o "${filename}.%(ext)s" -f 'best' "${video_url}" --get-filename)

            if [ "$convert" = "" ]; then
                :
            else
                ffmpeg -i "${file}" "${file%.*}${convert}"
                rm -f "${file}"
            fi
        fi
    else
        echo "You might wanna install youtube-dl for this command buddy."
    fi
}
