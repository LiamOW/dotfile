# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/liam/.oh-my-zsh"

ZSH_THEME="agnoster"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  )

source $ZSH/oh-my-zsh.sh

# ----------------------------------------------------------------------------------------
# EXPORTS
# ----------------------------------------------------------------------------------------

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export RUST_SRC_PATH="$(rustc --print sysroot)/bin"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ----------------------------------------------------------------------------------------
# ALIASES
# ----------------------------------------------------------------------------------------

# store dotfiles on github
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# use neovim if installed, else use vim
if [[ $+commands[nvim] ]];
  then alias vim='nvim';
fi

# alias ls with exa
if [[ $+command[exa] ]];
  then alias ls='exa'
fi

# alias ls with exa
if [[ $+command[bat] ]];
  then alias cat='bat'
fi

# ----------------------------------------------------------------------------------------
# FUNCTIONS
# ----------------------------------------------------------------------------------------
function mkd() {
  mkdir $1 && cd $1
}
