function ggp
    grep -Rn --exclude "*_test.go*" --exclude-dir ./bin --exclude-dir ./pkg/dcmoji/assets  --exclude-dir "\.git" --exclude-dir ./bin --exclude-dir ./build --exclude-dir ./vendor $argv .
end

