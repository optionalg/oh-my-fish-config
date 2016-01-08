function fabric_install_dependencies
        # python setup.py clean
        # python setup.py build
        set OLD_PWD $PWD
        cd /workspace/git/repos/connector-python
        git checkout master
        python setup.py clean -a
        python setup.py install --root=$OLD_PWD/lib --install-purelib=.
        if not test -d /workspace/git/repos/mysql-gcs/BIN/src/wrappers/python
                echo "Warning: Skipping MySQL GCS wrapper installation"
                false
        else
                cd /workspace/git/repos/mysql-gcs/BIN/src/wrappers/python
                cp -r lib/python/mysql_gcs $OLD_PWD/lib/
        end
        cd $OLD_PWD
        set -gx PYTHONPATH $PWD/lib
end
