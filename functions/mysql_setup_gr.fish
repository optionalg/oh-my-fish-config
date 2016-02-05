function mysql_setup_gr
        switch (count $argv)
                case 0
                        echo "Usage mysql_setup_gr <integer> where <integer> is the number of servers you want"
                        false
                case 1
                        # Preparing servers
                        for x in (seq $argv[1])
                                echo -e "\n\n\n##### Preparing server $x ####\n\n\n"
                                mysql_prepare $x
                                if test $status != 0
                                        echo -e "# ERROR: Problem preparing server $x\n"
                                        false
                                        break
                                end
                        end
                        # Starting Servers
                        # Needs to be done manually since Fish doesn't support sending functions to
                        # background
                        echo -e "\n\nStart the servers manually, and press any key to continue\n\n"
                        read i
                        echo "Creating replication user on all servers"
                        # Create string with replication ports
                        set xcom_ports ""
                        for x in (seq $argv[1])
                                if test $x -eq 1
                                        set xcom_ports 127.0.0.1:1030$x
                                else
                                        set xcom_ports (echo $xcom_ports,127.0.0.1:1030$x)
                                end
                        end
                        for x in (seq $argv[1])
                                echo "Creating replication user on server $x"
                                mysql -u root --host=127.0.0.1 --port=1300$x -e "create user rpl_user@'%';"
                                mysql -u root --host=127.0.0.1 --port=1300$x -e "grant replication slave on *.* to rpl_user@'%' identified by 'rpl_pass';"
                                mysql -u root --host=127.0.0.1 --port=1300$x -e "reset master;reset slave;"
                                mysql -u root --host=127.0.0.1 --port=1300$x -e "SET GLOBAL group_replication_group_name= '8a94f357-aab4-11df-86ab-c80aa9429562'";
                                mysql -u root --host=127.0.0.1 --port=1300$x -e "SET GLOBAL group_replication_recovery_user='rpl_user';"
                                mysql -u root --host=127.0.0.1 --port=1300$x -e "SET GLOBAL group_replication_recovery_password='rpl_pass';"
                                mysql -u root --host=127.0.0.1 --port=1300$x -e "SET GLOBAL group_replication_recovery_retry_count= 2;"
                                mysql -u root --host=127.0.0.1 --port=1300$x -e "SET GLOBAL group_replication_recovery_reconnect_interval=120;"
                                # if first server, enable bootstrap flag
                                if test $x -eq 1
                                        mysql -u root --host=127.0.0.1 --port=1300$x -e "SET GLOBAL group_replication_bootstrap_group=1;"
                                end
                                mysql -u root --host=127.0.0.1 --port=1300$x -e " SET GLOBAL group_replication_local_address='127.0.0.1:1030$x'"
                                mysql -u root --host=127.0.0.1 --port=1300$x -e " SET GLOBAL group_replication_peer_addresses='$xcom_ports'"
                                mysql -u root --host=127.0.0.1 --port=1300$x -e "START GROUP_REPLICATION;"
                                # if first server, disable bootstrap flag
                                if test $x -eq 1
                                        mysql -u root --host=127.0.0.1 --port=1300$x -e "SET GLOBAL group_replication_bootstrap_group=0;"
                                end
                        end
                        echo "# DONE!"
                case '*'
                        echo "Usage mysql_setup_gr <integer> where <integer> is the number of servers you want"
                        false
        end
end
