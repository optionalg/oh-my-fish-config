function fabric_run_tests
        set  MYSQLDUMP (which mysqldump)
        # Set variable that points to location of MYSQLCLIENT
        set MYSQLCLIENT (which mysql)
        export MYSQLCLIENT

        set addresses localhost:13001 localhost:13002 localhost:13003 localhost:13004 localhost:13005 localhost:13006 localhost:13007
        set storage 13000

        if not test -e setup.py
                echo "ERROR: Please move to the fabric topdir where test.py and setup.py scripts can be found."
                false
        else
                python setup.py build
                python test.py --build-dir=build -vvv --log-file=output.log --host=localhost --port=$storage --user=root --password="" --servers="$addresses" ^&1 | tee output.log
        end

end
