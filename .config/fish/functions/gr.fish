function gr
    set -x GIT_ROOT (git rev-parse --show-cdup)
    if [ "$GIT_ROOT" != '' ]
        cd $GIT_ROOT
    end
end
