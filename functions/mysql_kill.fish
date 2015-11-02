function mysql_kill
        set MYSQL_BIN_PTR ~/.mysql_bin_folder
        if not test -f $MYSQL_BIN_PTR
                echo "please use mysql_set to choose the Binary distribution folder"
                false
        else
                switch (count $argv)
                        case 0
                                echo "Usage mysql_kill <integer>"
                                false
                        case 1
                                set MYSQL_ROOT_FOLDER (cat $MYSQL_BIN_PTR)
                                echo "Using: " $MYSQL_ROOT_FOLDER
                                set ID $argv[1]
                                set BASEDIR $MYSQL_ROOT_FOLDER
                                set DATADIR $BASEDIR/DATA$ID
                                set PID (ps aux | grep -v grep | grep $MYSQL_ROOT_FOLDER/bin/mysqld | grep $DATADIR | awk '{print $2}')
                                if set -q PID
                                        ps aux | grep -v grep | grep $MYSQL_ROOT_FOLDER/bin/mysqld | grep $DATADIR
                                        echo "Killing pid: " $PID
                                        kill -9 $PID
                                end
                        case '*'
                                echo "Usage mysql_kill <integer>"
                                false
                end
        end
end
