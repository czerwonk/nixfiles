zshaddhistory() {
  emulate -L zsh

  whence ${${(z)1}[1]} >/dev/null || return 2

  if ! [[ "$1" =~ "(^( |git |cd |# ))" ]] ; then
    print -sr -- "${1%%$'\n'}"
    fc -p
  else
    return 1
  fi
}

# tmux
ssh() {
  if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm= | cut -c 1-4)" = "tmux" ]; then
    host=$(echo $* | egrep -o '[0-9a-z.\-]+\.([0-9a-z.]+)*' | head -n 1)
    if [ "$host" != "" ]; then
      tmux rename-window $(echo $host | cut -d '.' -f 1-3)
    fi
    command ssh "$@"
    tmux set-window-option automatic-rename "on" 1>/dev/null
  else
    command ssh "$@"
  fi
}
