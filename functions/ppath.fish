function ppath
        set OLD_PWD $PWD
        cd /workspace/git/repos/connector-python
        git checkout master
        python setup.py clean -a
        python setup.py install --root=$OLD_PWD --install-purelib=.
        cd $OLD_PWD
        set -gx PYTHONPATH $PWD
        set -gx COVERAGE_PROCESS_START /home/nelson/.coveragerc
end
