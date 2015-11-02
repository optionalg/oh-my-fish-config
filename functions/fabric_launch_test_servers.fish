function fabric_launch_test_servers
        if not test -d mysql-test
                echo "ERROR: mysql-test dir not found. This must be executed from within the root of the binary MYSQL distribution."
                false
        else
                set -x FABRIC_SCRIPTS "/home/nelson/Oracle/Scripts/Fabric"
                set OLD_PWD $PWD
                cp -f $FABRIC_SCRIPTS/rpl_fabric_gtid.* mysql-test/suite/rpl/t/
                cd mysql-test
                perl mtr rpl_fabric_gtid --mem --start
                cd ..
        end
end
