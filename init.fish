# Disable creation of  python .pyc files
# https://docs.python.org/2/using/cmdline.html#envvar-PYTHONDONTWRITEBYTECODE
set -gx PYTHONDONTWRITEBYTECODE 1

# Add mysql_bin_dir
set -x PATH ~/mysql_bin_dir $PATH

# Add meb directory
set -x PATH /workspace/tools/meb-4.0.0/bin $PATH

# Add pyenv
set -x PYENV_ROOT "$HOME/.pyenv"
set -x PATH "$PYENV_ROOT/bin" $PATH
status --is-interactive; and . (pyenv init -|psub)
