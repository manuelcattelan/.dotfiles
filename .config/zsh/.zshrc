# Lines configured by zsh-newuser-install
HISTFILE=$ZDOTDIR/.zhistory
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mcattelan/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#
# Prompt
#
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

    # Check for any changes (staged, unstaged, untracked)
    if ! command git diff-index --quiet HEAD -- 2>/dev/null || 
       [ -n "$(command git ls-files --others --exclude-standard 2>/dev/null)" ]; then
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
PROMPT='$(build_prompt) %F{yellow}➜%f '

#
# Aliases
#
alias ls='ls -v --color=auto'
alias ll='ls -lh'
alias la='ls -lAh'

alias rmdir='rm -rf'

alias startx='ssh-agent startx'

#
# Keybindings
#
autoload -U select-word-style
select-word-style bash

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

bindkey '^F' forward-word
bindkey '^B' backward-word

bindkey '^W' backward-kill-word
bindkey '^U' backward-kill-line

bindkey '^Y' autosuggest-accept

# Configurations
#
export FZF_DEFAULT_OPTS="--bind change:top"
export FZF_CTRL_T_OPTS="--height 100% --no-sort --reverse"
export FZF_CTRL_R_OPTS="--height 100% --no-sort --reverse"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Enable zsh-syntax-highlighting by sourcing the script.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable zsh-autosuggestions by sourcing the script.
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Enable zsh-history-substring-search by sourcing the script.
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
