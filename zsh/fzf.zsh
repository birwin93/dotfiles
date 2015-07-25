# Key bindings
# ------------
# CTRL-T - Paste the selected file path(s) into the command line
__fsel() {
  command find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | sed 1d | cut -b3- | $(__fzfcmd) -m | while read item; do
    printf '%q ' "$item"
  done
  echo
}

__fzfcmd() {
  [ ${FZF_TMUX:-1} -eq 1 ] && echo "fzf-tmux -d${FZF_TMUX_HEIGHT:-40%}" || echo "fzf"
}

__fselgit() {
  command git status --short | cut -c4- | $(__fzfcmd) -m
  echo
}

fzf-git-status-widget() {
  LBUFFER="${LBUFFER}$(__fselgit)"
  zle redisplay
}
zle     -N   fzf-git-status-widget
bindkey '^F' fzf-git-status-widget

fzf-file-widget() {
  LBUFFER="${LBUFFER}$(__fsel)"
  zle redisplay
}
zle     -N   fzf-file-widget
bindkey '^T' fzf-file-widget

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
  local selected restore_no_bang_hist
  if selected=$(fc -l 1 | $(__fzfcmd) +s --tac +m -n2..,.. --tiebreak=index --toggle-sort=ctrl-r -q "$LBUFFER"); then
    num=$(echo "$selected" | head -1 | awk '{print $1}' | sed 's/[^0-9]//g')
    if [ -n "$num" ]; then
      LBUFFER=!$num
      if setopt | grep nobanghist > /dev/null; then
        restore_no_bang_hist=1
        unsetopt no_bang_hist
      fi
      zle expand-history
      [ -n "$restore_no_bang_hist" ] && setopt no_bang_hist
    fi
  fi
  zle redisplay
}
zle     -N   fzf-history-widget
bindkey '^S' fzf-history-widget
