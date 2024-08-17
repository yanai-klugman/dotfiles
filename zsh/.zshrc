#!/usr/bin/env zsh

# --- Zsh Initialization and Performance Optimizations ---
# Enable Zsh profiling if ZPROF is set to true
[[ "$ZPROF" = true ]] && zmodload zsh/zprof

# Set ZDOTDIR for Zsh to look for configs in the stowed directory
export ZDOTDIR=${ZDOTDIR:-~/dotfiles/zsh}

# --- Function Definitions ---
# Function to safely source files
source_file() { [[ -f "$1" ]] && source "$1" }

# --- Environment Variables ---
export EDITOR=${EDITOR:-'nvim'}
export VISUAL=${VISUAL:-'code'}
export PAGER=${PAGER:-'less'}
export LANG=${LANG:-'en_US.UTF-8'}
export LC_ALL=${LC_ALL:-'en_US.UTF-8'}

# --- Path Configuration ---
typeset -U path
path=(
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/.pyenv/bin"
    $path
)

# --- Version Managers ---
# NVM configuration (handled by zsh-nvm plugin)
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

# Lazy-load pyenv
if (( $+commands[pyenv] )); then
    export PYENV_ROOT="$HOME/.pyenv"
    path=("$PYENV_ROOT/bin" $path)
    function pyenv() {
        unfunction pyenv
        eval "$(command pyenv init -)"
        eval "$(command pyenv virtualenv-init -)"
        pyenv "$@"
    }
fi

# --- History Configuration ---
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY INC_APPEND_HISTORY SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS HIST_REDUCE_BLANKS

# --- Zsh Options ---
setopt AUTO_CD EXTENDED_GLOB NOMATCH NOTIFY PROMPT_SUBST INTERACTIVE_COMMENTS
setopt AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT

# --- Completion System ---
# Load and initialize the completion system
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# Configure completions
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive matching

# --- Plugin Management ---
# Load Antibody plugins
source_file ~/.zsh_plugins.sh

# --- Prompt Configuration ---
# Load Oh-My-Posh prompt
if (( $+commands[oh-my-posh] )); then
    eval "$(oh-my-posh init zsh --config $ZDOTDIR/oh-my-posh/catppuccin-pine.omp.toml)"
fi

# --- Aliases ---
# Define command aliases
if (( $+commands[eza] )); then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -l --icons --group-directories-first'
    alias la='eza -la --icons --group-directories-first'
    alias lt='eza -T --icons --group-directories-first'
else
    alias ls='ls --color=auto'
    alias ll='ls -l'
    alias la='ls -la'
fi

(( $+commands[bat] )) && alias cat='bat --style=plain'
(( $+commands[rg] )) && alias grep='rg'
(( $+commands[fd] )) && alias find='fd'
(( $+commands[duf] )) && alias df='duf'
(( $+commands[dust] )) && alias du='dust'
(( $+commands[btm] )) && alias top='btm'

# Directory navigation aliases
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# Global aliases
alias -g G='| grep'
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'

# --- Key Bindings ---
# Set up key bindings
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Plugin-specific key bindings
if [[ -n ${functions[history-substring-search-up]} ]]; then
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi

if [[ -n ${functions[autosuggest-accept]} ]]; then
    bindkey '^ ' autosuggest-accept
fi

# --- WSL-Specific Configurations ---
# Add Windows system paths to $PATH in WSL
if [[ -f /proc/version ]] && grep -qi microsoft /proc/version; then
    path+=(
        "/mnt/c/Windows/system32"
        "/mnt/c/Windows"
        "/mnt/c/Windows/System32/Wbem"
        "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/"
    )
fi

# --- Local Configurations ---
# Source any local machine-specific overrides
source_file ~/.zshrc.local

# --- End Zsh Profiling ---
[[ "$ZPROF" = true ]] && zprof
