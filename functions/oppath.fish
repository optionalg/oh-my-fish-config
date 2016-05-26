function oppath
        if not test -d $PWD/mysql_gadgets
                echo "mysql_gadgets was directory not found"
                false
        else if not test -d $PWD/mysql
                echo "Connector python not installed"
                false
        else
                set -gx PYTHONPATH $PWD
                true
        end
end
