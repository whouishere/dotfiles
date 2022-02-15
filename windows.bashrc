alias ls='ls --color=auto'
alias mpv="mpv.com"
alias yt-dl='youtube-dl'

gh-clone () {
	git clone https://github.com/$1 $2
}

clipcat () {
    clip < $1
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
    local binary=yt-dlp

    if hash $binary 2>/dev/null ; then
        if [ $# -eq 0 ]; then
            echo "You didn't enter any arguments, dumbass."
        elif [ $1 = "-h" ] || [ $1 = "--help" ]; then
            echo "Usage: video-dl [OPTIONS] URL
            -o, --output           Specifies the output file, without the extension
            -c, --convert          Converts the file to the specified format
            --yt-dl                Use youtube-dl instead of yt-dlp
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
                    "--yt-dl")             binary="youtube-dl"  ;;
                    "" | *)                video_url="$arg";;
                esac

                last_arg="$arg"
            done

            if [ "$filename" = "" ]; then
                filename="%(title)s"
            fi

            $binary -o "${filename}.%(ext)s" "${video_url}"
            local file=$($binary -o "${filename}.%(ext)s" "${video_url}" --get-filename)

            if [ "$convert" = "" ]; then
                :
            else
                ffmpeg -i "${file}" "${file%.*}${convert}"
                rm -f "${file}"
            fi
        fi
    else
        echo "You might wanna install $binary for this command buddy."
    fi
}

# cool copy-paste :)
audio-dl () {
    local binary=yt-dlp

    if hash $binary 2>/dev/null ; then
        if [ $# -eq 0 ]; then
            echo "You didn't enter any arguments, dumbass."
        elif [ $1 = "-h" ] || [ $1 = "--help" ]; then
            echo "Usage: audio-dl [OPTIONS] URL
            -o, --output           Specifies the output file, without the extension
            -c, --convert          Converts the file to the specified format
            --no-cert              Sometimes ()
            --yt-dl                Use youtube-dl instead of yt-dlp
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
                    "--yt-dl")             binary="youtube-dl"  ;;
                    "" | *)                video_url="$arg";;
                esac

                last_arg="$arg"
            done

            if [ "$filename" = "" ]; then
                filename="%(title)s"
            fi

            $binary -o "${filename}.%(ext)s" -f 'bestaudio' "${video_url}"
            local file=$($binary -o "${filename}.%(ext)s" -f 'bestaudio' "${video_url}" --get-filename)

            if [ "$convert" = "" ]; then
                :
            else
                ffmpeg -i "${file}" "${file%.*}${convert}"
                rm -f "${file}"
            fi
        fi
    else
        echo "You might wanna install $binary for this command buddy."
    fi
}
