function mysql_connect
        switch (count $argv)
                case 0
                        echo "Usage mysql_connect <integer>"
                                false
                case 1
                        set ID $argv[1]
                        set MYSQL_CLIENT (which mysql)
                        eval $MYSQL_CLIENT -u root --host=127.0.0.1 --port=1300$ID
                case '*'
                                echo "Usage mysql_connect <integer>"
                                false
        end
end
