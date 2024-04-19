function kaj
    for job in (jobs -p)
        kill -9 $job
    end
end
