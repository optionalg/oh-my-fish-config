function orchestrator_install_dependencies
        # python setup.py clean
        # python setup.py build
        if not test -d $PWD/mysql_gadgets
                echo "Please change into the correct folder: mysql-orchestrator/gadgets/python"
                false
        else
                set OLD_PWD $PWD
                cd /workspace/git/repos/connector-python
                git checkout master
                python setup.py clean -a
                python setup.py install --root=$OLD_PWD --install-purelib=.
                cd $OLD_PWD
                set -gx PYTHONPATH $PWD
        end
end
