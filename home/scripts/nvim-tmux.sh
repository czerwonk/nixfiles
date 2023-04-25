#!/bin/bash
if [[ -z $TMUX ]]; then
  nvim $@
  exit 0
fi

tmux rename-window nvim
tmux split-window
tmux resize-pane -t 2 -y 10
tmux select-pane -t 1
tmux resize-pane -Z
nvim $@
tmux kill-pane -a -t 2
