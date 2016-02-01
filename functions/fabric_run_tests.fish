function fabric_run_tests
        set -x MYSQLDUMP (which mysqldump)
        echo $MYSQLDUMP
        # Set variable that points to location of MYSQLCLIENT
        set -x MYSQLCLIENT (which mysql)
        echo $MYSQLCLIENT

        set addresses localhost:13001 localhost:13002 localhost:13003 localhost:13004 localhost:13005 localhost:13006 localhost:13007
        set storage 13000

        if not test -e setup.py
                echo "ERROR: Please move to the fabric topdir where test.py and setup.py scripts can be found."
                false
        else
                rm -rf build
                python setup.py build
                cp lib/mysql_gcs/*.so build/lib/mysql_gcs
                python -u test.py $argv --build-dir=build -vvv --log-file=output.log --host=localhost --port=$storage --user=root --password="" --servers="$addresses" ^&1 | tee output.log
        end

end
