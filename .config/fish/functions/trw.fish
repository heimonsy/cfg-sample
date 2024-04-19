function trw
    set -l window_name (basename (pwd))
    tmux rename-window $window_name
end
