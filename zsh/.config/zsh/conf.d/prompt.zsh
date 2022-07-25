# initial setup
autoload -Uz vcs_info
autoload -Uz colors && colors
precmd() { vcs_info }
setopt prompt_subst

# function used to get git status
git_prompt() {
  BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/*\(.*\)/\1/')
  if [ ! -z $BRANCH ]; then
    STATUS=$(git status --short 2> /dev/null)
    if [ ! -z "$STATUS" ]; then
      echo "%F{yellow}✗ "
    fi
  fi
}

# prompt customization
PROMPT='%F{blue}%n%f in %F{blue}%1~%f ${vcs_info_msg_0_}$(git_prompt)'
zstyle ':vcs_info:*' enable git
zstyle ':vsc_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%s:%F{red}(%b)%f "
