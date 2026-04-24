eval "$(/opt/homebrew/bin/brew shellenv)"

typeset -gU path fpath
path=($HOME/.local/bin $path)

[[ -f ${ZDOTDIR:-$HOME}/.zprofile.local ]] && source ${ZDOTDIR:-$HOME}/.zprofile.local
