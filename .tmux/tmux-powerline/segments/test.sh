#!/bin/bash




# Pages free:                               68970.
# Pages active:                            899113.
# Pages inactive:                          904224.
# Pages speculative:                        38328.
# Pages throttled:                              0.
# Pages wired down:                        132495.
# Pages purgeable:                           4157.

lines=$(vm_stat)

pageFree=$(echo ${lines} | grep -o 'Pages free: [0-9]*' | grep -o '[0-9]*')
pageActive=$(echo ${lines} | grep -o 'Pages active: [0-9]*' | grep -o '[0-9]*')
pageInactive=$(echo ${lines} | grep -o 'Pages inactive: [0-9]*' | grep -o '[0-9]*')
pageSpeculative=$(echo ${lines} | grep -o 'Pages speculative: [0-9]*' | grep -o '[0-9]*')
pageThrottled=$(echo ${lines} | grep -o 'Pages throttled: [0-9]*' | grep -o '[0-9]*')
pageWiredDown=$(echo ${lines} | grep -o 'Pages wired down: [0-9]*' | grep -o '[0-9]*')
pagePurgeable=$(echo ${lines} | grep -o 'Pages purgeable: [0-9]*' | grep -o '[0-9]*')
fileBacked=$(echo ${lines} | grep -o 'File-backed pages: [0-9]*' | grep -o '[0-9]*')

totalPages=$(($pageFree + $pageActive + $fileBacked + $pageSpeculative + $pageWiredDown))

usedPages=$(($fileBacked + $pageSpeculative + $pageWiredDown))

echo "Total pages: $totalPages"
echo "Used  pages: $usedPages"

mem_usage=$(echo "$usedPages $totalPages" | awk '{printf "%.1f%%", ($1/$2)*100}')


echo "Memory usage: $mem_usage"

# echo "Usage percentage: $(($usedPages / $totalPages))"
