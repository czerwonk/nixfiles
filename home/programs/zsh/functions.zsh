zshaddhistory() {
  emulate -L zsh

  # exclude failed commands
  whence ${${(z)1}[1]} >/dev/null || return 2

  # exclude multiline commands
  [[ "$1" == *$'\n'*$'\n'* ]] && return 1

  # exclude inline secret env vars (VAR=value command)
  [[ "$1" =~ "^[A-Za-z_]*(_)?(PASSWORD|SECRET|TOKEN|KEY|API|AUTH|CREDENTIAL)[A-Za-z_]*=" ]] && return 1

  # exclude secrets
  [[ "$1" =~ "(Bearer |-----BEGIN)" ]] && return 1

  # exclude defined list of commands
  if ! [[ "$1" =~ "(^( |git commit |git c |cd |# |export ))" ]] ; then
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
