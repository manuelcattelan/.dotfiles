# Configure shell's history file and behavior
HISTFILE=$ZDOTDIR/.zhistory
HISTSIZE=1000
SAVEHIST=1000

# Enable vi mode for the shell
bindkey -v

# Add Docker CLI completions to the completion path
fpath=(/Users/mcattelan/.docker/completions $fpath)
# Enable completion system for shell commands completion (e.g. command flags)
zstyle :compinstall filename "$ZDOTDIR/.zshrc"
autoload -Uz compinit && compinit

# Enable prompt substitution for dynamic content
setopt prompt_subst
# Load version control system module
autoload -Uz vcs_info
# Configure version control information display
# - Enable git support
# - Configure version control information to display
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats "" "%s:%b" ""
# Check if the git repository has any changes
# Returns "*" if the repository is dirty
git_dirty() {
    # Skip if not in a git repository
    command git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return
    # Use git status --porcelain for more reliable detection, while avoiding race conditions with git diff-index
    local git_status_output=$(command git status --porcelain 2>/dev/null)
    # If there's any output from git status --porcelain, the repo is dirty
    if [[ -n "$git_status_output" ]]; then
        echo "*"
    fi
}
# Format the current path to show at most 3 directory levels
# When path is deeper than 3 levels, display "../dir3/dir2/dir1"
format_path() {
    # Replace $HOME with ~ in the current path
    local path_string="${PWD/#$HOME/~}"
    # Split path into components
    local path_components=(${(s:/:)path_string})
    local path_length=${#path_components}
    # Show shortened path for deep directories
    if [[ $path_length -gt 3 ]]; then
        echo "../${path_components[-3]}/${path_components[-2]}/${path_components[-1]}"
    else
        echo "$path_string"
    fi
}
# Build the prompt string with path and git information
build_prompt() {
    local path_formatted=$(format_path)
    # If in a git repository, show path + VCS info, otherwise just show path
    if [[ -n "$vcs_info_msg_1_" ]]; then
        echo "%F{blue}${path_formatted}%f %F{8}$vcs_info_msg_1_$(git_dirty)%f"
    else
        echo "%F{blue}${path_formatted}%f"
    fi
}
# Pre-command hook: Update VCS information before displaying the prompt
precmd() {
    # Disable prompt substitution locally to prevent nested evaluation
    setopt localoptions nopromptsubst
    # Refresh version control information
    vcs_info
}
# Define prompt with:
# - Path and git information from build_prompt
# - Arrow symbol (➜) as prompt character
PROMPT='$(build_prompt) %F{yellow}λ%f '

alias ls='ls -v --color=auto'
alias ll='ls -lh'
alias la='ls -lAh'
alias rmdir='rm -rf'
alias claude="CLAUDE_CONFIG_DIR=$HOME/.claude $XDG_CONFIG_HOME/nvm/versions/node/v22.19.0/bin/claude"

# Custom key bindings for text manipulation and plugin actions
autoload -U select-word-style
select-word-style bash
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey '^F' forward-word
bindkey '^B' backward-word
bindkey '^W' backward-kill-word
bindkey '^U' backward-kill-line
bindkey '^Y' autosuggest-accept

# Zsh-specific plugins
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Set up nvm key bindings and fuzzy completion
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Set up pnpm key bindings and fuzzy completion
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
