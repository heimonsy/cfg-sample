function gbg
    cd pkg
    ln -f -s linux-amd64 linux_amd64
    cd -
    set -x GOPATH $PWD
end
