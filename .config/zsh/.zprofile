#!/bin/zsh

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath
# Update path for executables with custom $HOME/.local/bin folder.
path=($HOME/.local/bin $path)
