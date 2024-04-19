# Prints tmux session info.
# Assuems that [ -n "$TMUX"].
#
run_segment() {
    if shell_is_osx; then
        local os_icon=""
    else
        local os_icon=" "
    fi
    # echo "#[fg=colour196]$os_icon"
    echo "$os_icon"
}
