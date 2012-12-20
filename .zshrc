# My .zshrc file
#
# Skip all this for non-interactive shells
[[ -z "$PS1" ]] && return
 
# Set prompt (white and purple, nothing too fancy)
PS1=$'%{\e[0;37m%}%B%*%b %{\e[0;35m%}%m:%{\e[0;37m%}%~ %(!.#.>) %{\e[00m%}'
 
# Set less options
if [[ -x $(which less) ]]
then
    export PAGER="less"
    export LESS="--ignore-case --LONG-PROMPT --QUIET --chop-long-lines -Sm --RAW-CONTROL-CHARS --quit-if-one-screen --no-init"
    if [[ -x $(which lesspipe.sh) ]]
    then
        LESSOPEN="| lesspipe.sh %s"
        export LESSOPEN
    fi
fi
 
# Set default editor
if [[ -x $(which vim) ]]
then
    export EDITOR="vim"
    export USE_EDITOR=$EDITOR
    export VISUAL=$EDITOR
fi
 
# Zsh settings for history
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."
export HISTSIZE=25000
export HISTFILE=~/.zsh_history
export SAVEHIST=25000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
 
# Completation
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
 
# Prompts for confirmation after 'rm *' etc
# Helps avoid mistakes like 'rm * o' when 'rm *.o' was intended
setopt RM_STAR_WAIT
 
# Background processes aren't killed on exit of shell
setopt AUTO_CONTINUE
 
# Don�t write over existing files with >, use >! instead
setopt NOCLOBBER
 
# Don�t nice background processes
setopt NO_BG_NICE
 
# Watch other user login/out
watch=notme
export LOGCHECK=60
 
# Enable color support of ls
if [[ "$TERM" != "dumb" ]]; then
    if [[ -x `which dircolors` ]]; then
        eval `dircolors -b`
        alias 'ls=ls --color=auto'
    fi
fi
 
# Short command aliases
alias 'l=ls'
alias 'la=ls -A'
alias 'll=ls -l'
alias 'lq=ls -Q'
alias 'lr=ls -R'
alias 'lrs=ls -lrS'
alias 'lrt=ls -lrt'
alias 'lrta=ls -lrtA'
alias 'j=jobs -l'
alias 's=ls | grep'
alias 'kw=kwrite'
alias 'tf=tail -f'
alias 'grep=grep --colour'
alias '..=cd ..'
alias 'home=cd ~/'
 
# Play safe!
alias 'rm=rm -i'
alias 'mv=mv -i'
alias 'cp=cp -i'
 
# For convenience
alias 'mkdir=mkdir -p'
alias 'dus=du -ms * | sort -n'
 
# Typing errors...
alias 'cd..=cd ..'
 
# Running 'b.ps' runs 'q b.ps'
alias -s ps=q
alias -s html=q
 
# Global aliases (expand whatever their position)
#  e.g. find . E L
alias -g L='| less'
alias -g H='| head'
alias -g S='| sort'
alias -g T='| tail'
alias -g N='> /dev/null'
alias -g E='2> /dev/null'
 
# Aliases to use this
# Use e.g. 'command gv' to avoid
alias 'amarok=z amarok'
alias 'firefox=z firefox'
alias 'icedove=z icedove'
alias 'gimp=z gimp'
alias 'gpdf=z gpdf'
alias 'gv=z gv'
alias 'k3b=z k3b'
alias 'kate=z kate'
alias 'kmail=z kmail'
alias 'konqueror=z konqueror'
alias 'konsole=z konsole'
alias 'kontact=z kontact'
alias 'kopete=z kopete'
alias 'kpdf=z kpdf'
alias 'kwrite=z kwrite'
alias 'ooffice=z soffice-beta'
alias 'thunderbird=z thunderbird'
 
# Quick find
f() {
    echo "find . -iname \"*$1*\""
    find . -iname "*$1*"
}
 
 
# Clear konsole history
alias 'zaph=dcop $KONSOLE_DCOP_SESSION clearHistory'
 
# When directory is changed set xterm title to host:dir
chpwd() {
    [[ -t 1 ]] || return
    case $TERM in
        sun-cmd) print -Pn "\e]l%~\e\\";;
       *xterm*|rxvt|(dt|k|E)term) print -Pn "\e]2;%m:%~\a";;
   esac
}
 
# For changing the umask automatically
chpwd () {
   case $PWD in
       $HOME/[Dd]ocuments*)
           if [[ $(umask) -ne 077 ]]; then
               umask 0077
               echo -e "\033[01;32mumask: private \033[m"
           fi;;
       */[Ww]eb*)
           if [[ $(umask) -ne 072 ]]; then
               umask 0072
               echo -e "\033[01;33mumask: other readable \033[m"
           fi;;
       /vol/nothing)
           if [[ $(umask) -ne 002 ]]; then
               umask 0002
               echo -e "\033[01;35mumask: group writable \033[m"
           fi;;
       *)
           if [[ $(umask) -ne 022 ]]; then
               umask 0022
               echo -e "\033[01;31mumask: world readable \033[m"
           fi;;
   esac
}
cd . &> /dev/null
 
# For quickly plotting data with gnuplot.  Arguments are files for 'plot "" with lines'.
plot () {
   echo -n '(echo set term png; '
   echo -n 'echo -n plot \"'$1'\" with lines; '
   for i in $*[2,$#@]; echo -n 'echo -n , \"'$i'\" with lines; '
   echo 'echo ) | gnuplot | display png:-'
 
   (
        echo "set term png"
        echo -n plot \"$1\" with lines
        for i in $*[2,$#@]; echo -n "," \"$i\" "with lines"
        ) | gnuplot | display png:-
}
 
# Rotate a jpeg, losslessly
jrotate-r () {
   for i in $*; do
        exiftran -9 -b -i $i
   done
}
 
# Print some stuff
date
if [[ -x `which fortune` ]]; then
   echo
   fortune -a 2> /dev/null
fi
 
# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _match
zstyle ':completion:*' completions 0
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' glob 0
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '+m:{a-z}={A-Z} r:|[._-]=** r:|=**' '' '' '+m:{a-z}={A-Z} r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 1 numeric
zstyle ':completion:*' substitute 0
zstyle :compinstall filename "$HOME/.zshrc"
 
autoload -Uz compinit
compinit
# End of lines added by compinstall
 
zstyle -d users
#zstyle ':completion:*' users mrb04 matt
zstyle ':completion:*:*:*:users' ignored-patterns \
   adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
   named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
   rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs backup  bind  \
   dictd  gnats  identd  irc  man  messagebus  postfix  proxy  sys  www-data \
   avahi Debian-exim hplip list cupsys haldaemon ntpd proftpd statd
 
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#lost+found' '(*/)#CVS'
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
 
zstyle ':completion:*:(rm|kill|diff):*' ignore-line yes
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
 
# Filename suffixes to ignore during completion (except after rm command)
# This doesn't seem to work
#zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' '*?.old' '*?.pro' '*~'
#zstyle ':completion:*:(all-|)files' file-patterns '(*~|\\#*\\#):backup-files' 'core(|.*):core\ files' '*:all-files'
 
zstyle ':completion:*:*:rmdir:*' file-sort time
 
zstyle ':completion:*' local matt.blissett.me.uk /web/matt.blissett.me.uk
 
# CD to never select parent directory
zstyle ':completion:*:cd:*' ignore-parents parent pwd
 
# Quick ../../..
rationalise-dot() {
   if [[ $LBUFFER = *.. ]]; then
        LBUFFER+=/..
   else
        LBUFFER+=.
   fi
}
zle -N rationalise-dot
bindkey . rationalise-dot
 
autoload zsh/sched
 
# Copys word from earlier in the current command line
# or previous line if it was chosen with ^[. etc
autoload copy-earlier-word
zle -N copy-earlier-word
bindkey '^[,' copy-earlier-word
 
# Cycle between positions for ambigous completions
autoload cycle-completion-positions
zle -N cycle-completion-positions
bindkey '^[z' cycle-completion-positions
 
# Increment integer argument
autoload incarg
zle -N incarg
bindkey '^X+' incarg
 
# Write globbed files into command line
autoload insert-files
zle -N insert-files
bindkey '^Xf' insert-files
 
# Play tetris
#autoload -U tetris
#zle -N tetris
#bindkey '^X^T' tetris
 
# xargs but zargs
autoload -U zargs
 
# Calculator
autoload zcalc
 
# Line editor
autoload zed
 
# Renaming with globbing
autoload zmv
 
# Various reminders of things I forget...
# (Mostly useful features that I forget to use)
# vared
# =ls turns to /bin/ls
# =(ls) turns to filename (which contains output of ls)
# <(ls) turns to named pipe
# ^X* expand word
# ^[^_ copy prev word
# ^[A accept and hold
# echo $name:r not-extension
# echo $name:e extension
# echo $xx:l lowercase
# echo $name:s/foo/bar/
 
# Quote current line: M-'
# Quote region: M-"
 
# Up-case-word: M-u
# Down-case-word: M-l
# Capitilise word: M-c
 
# kill-region
 
# expand word: ^X*
# accept-and-hold: M-a
# accept-line-and-down-history: ^O
# execute-named-cmd: M-x
# push-line: ^Q
# run-help: M-h
# spelling correction: M-s
 
# echo ${^~path}/*mous*