#!/bin/sh
#
if [ "$(uname)" = "Darwin" ]; then
    # Use vm_stat and sysctl to get system info
    vmstat=($(vm_stat | grep -o '[0-9]\+'))

    # "Pages free:"
    pfree=${vmstat[1]}
    # "Pages wired down:"
    pwired=${vmstat[6]}
    # "Pages inactive:"
    pinact=${vmstat[3]}
    # "Anonymous pages:"
    panon=${vmstat[14]}
    # "Pages occupied by compressor:"
    pcomp=${vmstat[16]}
    # "Pages purgeable:"
    ppurge=${vmstat[7]}
    # "File-backed pages:"
    pfback=${vmstat[13]}

    total_mem=$(sysctl -n hw.memsize)

    # Arithmetics
    total_mem=$(echo "scale=2; $total_mem / 1073741824" | bc)
    pfree=$(echo "scale=2; $pfree * 4096 / 1073741824" | bc)
    pwired=$(echo "scale=2; $pwired * 4096 / 1073741824" | bc)
    pinact=$(echo "scale=2; $pinact * 4096 / 1073741824" | bc)
    panon=$(echo "scale=2; $panon * 4096 / 1073741824" | bc)
    pcomp=$(echo "scale=2; $pcomp * 4096 / 1073741824" | bc)
    ppurge=$(echo "scale=2; $ppurge * 4096 / 1073741824" | bc)
    pfback=$(echo "scale=2; $pfback * 4096 / 1073741824" | bc)

    # OSX Activity monitor formulas
    free=$(echo "scale=2; $pfree + $pinact" | bc)
    cached=$(echo "scale=2; $pfback + $ppurge" | bc)
    appmem=$(echo "scale=2; $panon - $ppurge" | bc)
    used=$(echo "scale=2; $appmem + $pwired + $pcomp" | bc)

    myused=$(echo "scale=2; $used + $free + $appmem + $pwired" | bc)


    printf '%.1f' $(echo "scale=4; $myused / $total_mem * 100" | bc) 

    # Display the hud
    # printf '                 total     used     free   appmem    wired   compressed\n'
    # printf 'Mem:          %.2fGb %.2fGb %.2fGb %.2fGb %.2fGb %.2fGb\n' $total_mem $used $free $panon $pwired $pcomp
    # printf '+/- Cache:             %.2fGb %.2fGb\n' $cached $pinact
    # sysctl -n -o vm.swapusage | awk '{   if( $3+0 != 0 )  printf( "Swap(%2.0f%s):    %6.0fMb %6.0fMb %6.0fMb\n", ($6+0)*100/($3+0), "%", ($3+0), ($6+0), $9+0); }'
    # sysctl -n -o vm.loadavg | awk '{printf( "Load Avg:        %3.2f %3.2f %3.2f\n", $2, $3, $4);}'
else
    free $@
fi
