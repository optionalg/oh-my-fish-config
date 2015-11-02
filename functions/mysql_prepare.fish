function mysql_prepare
        set MYSQL_BIN_PTR ~/.mysql_bin_folder
        if not test -f $MYSQL_BIN_PTR
                echo "please use mysql_set to choose the Binary distribution folder"
                false
        else
                switch (count $argv)
                        case 0
                                echo "Usage mysql_prepare <integer>"
                                false
                        case 1
                                set MYSQL_ROOT_FOLDER (cat $MYSQL_BIN_PTR)
                                echo "Using: " $MYSQL_ROOT_FOLDER
                                set ID $argv[1]
                                set BASEDIR $MYSQL_ROOT_FOLDER
                                set DATADIR $BASEDIR/DATA$ID
                                if test -d $DATADIR
                                        echo $DATADIR " already existed. Removing it..."
                                        and rm -rf $DATADIR
                                        and echo "removed."
                                end
                                mkdir -p $DATADIR
                                # different initialization function depending on mysql_version
                                switch $MYSQL_ROOT_FOLDER
                                        case '*-5.6*'
                                                echo "5.6 Server detected"
                                                eval $MYSQL_ROOT_FOLDER/scripts/mysql_install_db --no-defaults --basedir=$BASEDIR --datadir=$DATADIR
                                        case '*-5.7*'
                                                echo "5.7 server detected"
                                                eval $MYSQL_ROOT_FOLDER/bin/mysqld --initialize-insecure --datadir=$DATADIR --basedir=$BASEDIR
                                        case '*'
                                                echo "MySQL Version not yet supported"
                                                false
                                end
                        case '*'
                                echo "Usage mysql_prepare <integer>"
                                false
                end
        end
end
