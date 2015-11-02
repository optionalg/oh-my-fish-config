function mysql_shutdown
        set MYSQL_BIN_PTR ~/.mysql_bin_folder
        if not test -f $MYSQL_BIN_PTR
                echo "please use mysql_set to choose the Binary distribution folder"
                false
        else
                switch (count $argv)
                        case 0
                                echo "Usage mysql_shutdown <integer>"
                                false
                        case 1
                                set MYSQL_ROOT_FOLDER (cat $MYSQL_BIN_PTR)
                                echo "Using: " $MYSQL_ROOT_FOLDER
                                set ID $argv[1]
                                set BASEDIR $MYSQL_ROOT_FOLDER
                                set MYSQLADMIN $BASEDIR/bin/mysqladmin
                                eval $MYSQLADMIN  -u root --host=127.0.0.1 --port=1300$ID shutdown
                        case '*'
                                echo "Usage mysql_shutdown <integer>"
                                false
                end
        end
end
