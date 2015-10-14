function get_server_binaries
        set OLD_PWD $PWD
        set -x BINARIES_HOME "/workspace/servers/"
        cd /workspace/git/repos/mysql-utilities-tools/
        git checkout master
        set -x PYTHONPATH $PWD
        python -u hudson/get_server_binaries.py $argv
        cd $OLD_PWD
end
