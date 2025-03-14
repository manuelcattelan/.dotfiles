#!/bin/zsh

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath

# Update path for executables with custom $HOME/.scripts folder.
path=($HOME/.scripts $path)
