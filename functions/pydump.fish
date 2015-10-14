function pydump
    set pid (coredumpctl list python2 | tail -n 1 | awk '{print $5}')
    set exe (coredumpctl list python2 | tail -n 1 | awk '{print $10}')
    echo "Creating core dump for pid " $pid
    coredumpctl dump $pid > latest.dump
    echo "opening gdb with executable " $exe
    gdb --core latest.dump --exec $exe
end
