function clear
    if [ $TMUX -eq 0 ]
        /usr/bin/clear
    else
        /usr/bin/clear
        tmux clear-history 2>/dev/null || true
    end
end
