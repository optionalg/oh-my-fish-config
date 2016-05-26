function mysql_set
        set MYSQL_BIN_PTR ~/.mysql_bin_folder
        if not count $argv > /dev/null
                echo "Usage mysql_set <path_to_mysql_binary_distribution>"
                false
        else
                if not test -f $argv/bin/mysqld -a -d $argv/mysql-test
                        echo $argv "is not a valid root for a binary MySQL package"
                        false
                else
                        # $argv is a valid dir
                        rm -f $MYSQL_BIN_PTR
                        echo $argv > $MYSQL_BIN_PTR
                        rm -f ~/mysql_bin_dir
                        ln -s $argv/bin ~/mysql_bin_dir
                        echo "MySQL binary package in:'" $argv "' will be used from now on."
                end
        end
end
