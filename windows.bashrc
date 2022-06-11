alias ls='ls --color=auto'
alias mpv='mpv.com'
alias python3='py'
alias yt-dl='youtube-dl'
alias msbuild='msbuild.exe'

# fuck git bash's perl install.
export PERL5LIB=/c/libs-comps/Strawberry/perl/vendor/lib:/c/libs-comps/Strawberry/perl/site/lib
export DOTNET_CLI_TELEMETRY_OPTOUT=1

gh-clone () {
	git clone https://github.com/$1 $2
}

clipcat () {
    clip < $1
}

extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1         ;;
             *.tar.gz)    tar xzf $1         ;;
             *.tar.xz)    tar xf $1          ;;
             *.tar.zst)   tar --zstd -xf $1  ;;
             *.bz2)       bunzip2 $1         ;;
             *.rar)       rar x $1           ;;
             *.gz)        gunzip $1          ;;
             *.xz)        unxz $1            ;;
             *.tar)       tar xf $1          ;;
             *.tbz2)      tar xjf $1         ;;
             *.tgz)       tar xzf $1         ;;
             *.zip)       unzip $1           ;;
             *.Z)         uncompress $1      ;;
             *.7z)        7z x $1            ;;
             *.zst)       zstd -d $1         ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

