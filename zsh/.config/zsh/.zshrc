# drive config with antidote
ANTIDOTE_HOME=$ZDOTDIR/.plugins
zstyle ':antidote:bundle' use-friendly-names 'yes'

# clone antidote if necessary and generate a static plugin file
zhome=${ZDOTDIR:-$HOME}
if [[ ! $zhome/.zsh_plugins.zsh -nt $zhome/.zsh_plugins.txt ]]; then
    [[ -e $zhome/.antidote ]] \
        || git clone --depth=1 https://github.com/mattmc3/antidote.git $zhome/.antidote
            [[ -e $zhome/.zsh_plugins.txt ]] || touch $zhome/.zsh_plugins.txt
            (
            source $zhome/.antidote/antidote.zsh
            antidote bundle <$zhome/.zsh_plugins.txt >$zhome/.zsh_plugins.zsh
        )
fi

# uncomment if you want your session to have commands like `antidote update`
autoload -Uz $zhome/.antidote/functions/antidote

# source static plugins file
source $zhome/.zsh_plugins.zsh
unset zhome
