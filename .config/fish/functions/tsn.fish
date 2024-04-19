function tsn
    set -l session_name (basename (pwd))
    tmux new-session -A -s $session_name
end
