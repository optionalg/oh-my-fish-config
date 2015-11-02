function fppath
        if not test -d $PWD/lib
                echo "lib was directory not found"
                false
        else
                set -gx PYTHONPATH $PWD/lib
        end
end
