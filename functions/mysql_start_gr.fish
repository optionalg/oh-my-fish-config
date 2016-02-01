function mysql_start_gr
        set MYSQL_BIN_PTR ~/.mysql_bin_folder
        if not test -f $MYSQL_BIN_PTR
                echo "please use mysql_set to choose the Binary distribution folder"
                false
        else
                switch (count $argv)
                        case 0
                                echo "Usage mysql_start <integer>"
                                false
                        case 1
                                set MYSQL_ROOT_FOLDER (cat $MYSQL_BIN_PTR)
                                echo "Using: " $MYSQL_ROOT_FOLDER
                                set ID $argv[1]
                                set BASEDIR $MYSQL_ROOT_FOLDER
                                set DATADIR $BASEDIR/DATA$ID
                                set SOCKET $DATADIR/mysql.sock

                                if not test -d $DATADIR
                                        echo "ERROR:"$DATADIR " does not exist. Use mysql_prepare first."
                                        false
                                else
                                        # different initialization function depending on mysql_version
                                        switch $MYSQL_ROOT_FOLDER
                                        case '*-5.7*'
                                                echo "5.7 server detected"
                                                eval $MYSQL_ROOT_FOLDER/bin/mysqld --no-defaults --basedir=$BASEDIR --datadir=$DATADIR -P 1300$ID --socket=$SOCKET --server-id=$ID --gtid-mode=on --enforce-gtid-consistency=on --log-bin=bin-log --binlog-format=row --log-slave-updates --report-host=localhost --relay-log-info-repository=TABLE --master-info-repository=TABLE --transaction-write-set-extraction=MURMUR32 --binlog-checksum=NONE --plugin-dir=lib/plugin --plugin-load=group_replication.so
                                        case '*'
                                                echo "MySQL Version not yet supported"
                                                false
                                        end
                                end

                        case '*'
                                echo "Usage mysql_start <integer>"
                                false
                end
        end
end
