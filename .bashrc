# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#############################################
# PATH
#############################################

if [ -d ~/bin ]; then
  export PATH=$PATH:~/bin
fi

# EXPORTS
export PATH="/usr/local:$PATH"
export PATH="/sbin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.cargo/env:$PATH"
export PATH="$HOME/local:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm:$PATH"
export PATH="$HOME/.npm/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
export PATH="$HOME/racket/bin:$PATH"
export PATH="$HOME/texmf:$PATH"

. /home/liam/.nix-profile/etc/profile.d/nix.sh
eval "$(direnv hook bash)"

#############################################
# ALIASES
#############################################

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Aliases
alias ls='exa'
alias cat='bat'
alias refresh='source ~/.bashrc'
alias open='xdg-open'
alias cb='cargo b'
alias cbr='cargo b --release'
alias cr='cargo r'
alias crr='cargo r --release'

# use neovim if installed, else use vim
if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
  alias vi='nvim'
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    # alias ls='ls --color=auto'
    # alias dir='dir --color=auto'
    # alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#############################################
# MISC
#############################################

# set fzf to use ripgrep by default

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --no-ignore"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# enable vi-mode in bash shell
# set -o vi

export VISUAL=nvim
export EDITOR=nvim

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# automatically cd when a directory name is entered by itself
shopt -s autocd

# autocorrect minor typos
shopt -s dirspell
shopt -s cdspell

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#############################################
# HISTORY
#############################################

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL="erasedups:ignoreboth"

# append to the history file, don't overwrite it
shopt -s histappend

# save multiline commands as one command
shopt -s cmdhist

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=500000
HISTFILESIZE=100000

# don't record these commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history"

#############################################
# VISUALS
#############################################

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;32m\]\u\[\033[01;32m\]@\[\033[01;32m\]\h\[\033[00m\] \[\033[01;34m\]\W\[\033[00m\] \$ '
else
    PS1='\u@\h \W \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \W\a\]$PS1"
    ;;
*)
    ;;
esac

export PS1

# Base16 config
# BASE16_SHELL="$HOME/.config/base16-shell/"
# [ -n "$PS1" ] && \
#     [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
#         eval "$("$BASE16_SHELL/profile_helper.sh")"

#############################################
# COMMANDS
#############################################

mkd() {
    mkdir -p $1 && cd $1
}

#############################################
# SECRET
#############################################

function showsecret()
{
  gpg -q -d ~/.secret.gpg
}

function editsecret()
{
  out=$(mktemp --tmpdir=$HOME -u)
  # out=$(TMPDIR=$HOME mktemp -u -t $RANDOM)
  gpg -q -o $out -d ~/.secret.gpg && chmod go-rwx $out && ${EDITOR:=vim} $out && gpg --yes -q -o ~/.secret.gpg -e -r 'Liam Woodward' $out
  rm -f $out
}

function mksecret()
{
    # no key, lets make one
    if [ -z "$(gpg --list-keys 2>/dev/null)" ]; then
        gpg --gen-key
    fi

    # no secret.gpg
    if [ -e ~/.secret.gpg ]; then return;fi
    out=$(TMPDIR=$HOME mktemp -u -t $RANDOM)
    touch $out
    gpg --yes -q -o ~/.secret.gpg -e -r 'Liam Woodward' $out
    rm -f $out
}
