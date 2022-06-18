alias ls='ls --color=auto'
alias yt-dl='youtube-dl'
alias mpv='mpv.com'
alias python3='py'
alias msbuild='msbuild.exe'
alias perl='/c/libs-comps/Strawberry/perl/bin/perl'

# fuck git bash's perl install.
export PERL5LIB=/c/libs-comps/Strawberry/perl/vendor/lib:/c/libs-comps/Strawberry/perl/site/lib:/c/libs-comps/Strawberry/perl/lib
export DOTNET_CLI_TELEMETRY_OPTOUT=1

git-clone () {
    if [ "$2" = "-ssh" -o "$2" = "--ssh" ]; then
        git clone git@$1:$3 $4
    else
	    git clone https://$1/$2 $3
    fi
}

gh-clone () {
	git-clone github.com $@
}

gl-clone () {
    git-clone gitlab.com $@
}

clipcat () {
    clip < $1
}

search-history () {
    cat ~/.bash_history | grep $1
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

