#!/bin/zsh

_venv_load() {
  # Look for closest `.venv` directory recursively upward
  D="$PWD" && VENV_ROOT=
  while true; do
    [ -d "$D/.venv" ] && VENV_ROOT="$D/.venv" && break # Directory found
    [ !  "$D"      ]                          && break # Arrived at root
    D=${D%/*} # Scan parent directory (remove shortest matching suffix)
  done

  if [ "$VENV_ROOT" ]; then
    if [ "$VIRTUAL_ENV" ]; then
      [ "$VENV_ROOT" = "$VIRTUAL_ENV" ] && return
      deactivate
      echo deactivate
    fi

    source "$VENV_ROOT"/bin/activate
  elif [ "$VIRTUAL_ENV" ]; then
    deactivate
  fi
}

autoload -U add-zsh-hook      # Enable option to add hooks
add-zsh-hook chpwd _venv_load # Run method on every `cd` call
