function get_server_binaries
        set OLD_PWD $PWD
        set -x BINARIES_HOME "/workspace/servers/"
        cd /workspace/git/repos/mysql-utilities-tools/
        git checkout master
        set -x PYTHONPATH $PWD
        # download binaries
        python -u hudson/get_server_binaries.py $argv
        # extract binaries
        cd $BINARIES_HOME
        for dir in RELEASED UPCOMING
                cd $dir
                for f in (echo *.tar.gz)
                        echo "extracting " $f "..."
                        tar -xf $f
                        rm -f $f
                end
                cd $BINARIES_HOME
        end
        cd $OLD_PWD
end
