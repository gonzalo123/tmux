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
alias 'df=df -h'
 
# Play safe!
alias 'rm=rm -i'
alias 'mv=mv -i'
alias 'cp=cp -i'
 
# For convenience
alias 'mkdir=mkdir -p'
alias 'dus=du -ms * | sort -n'
 
# Typing errors...
alias 'cd..=cd ..'
 
# Print some stuff
date

stty ixany
stty ixoff -ixon


